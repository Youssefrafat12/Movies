import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies_app/api/model/movie_details_response/movie.dart';
import 'package:movies_app/features/main/tabs/profile/watch/watch_list_service.dart';
import 'package:movies_app/features/main/tabs/profile/widgets/custom_column.dart';
import 'package:movies_app/services/profile_service.dart';
import 'package:movies_app/services/movie_history_service.dart';
import 'package:movies_app/features/main/tabs/profile/widgets/history_view.dart';
import 'package:movies_app/widgets/custom_elevated_button.dart';
import 'package:movies_app/l10n/app_localizations.dart';
import 'package:movies_app/utils/app_assets.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_routes.dart';
import 'package:movies_app/utils/app_styles.dart';
import 'package:movies_app/utils/size_utils.dart';
import 'package:movies_app/widgets/movie_card_item.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  String profileName = 'John Safwat';
  String profileAvatar = AppAssets.profileImage8;
  late StreamSubscription<List<Movie>> _watchListSubscription;
  List<Movie> _watchListMovies = [];
  Object? _watchListError;
  late Future<List<Movie>> _historyFuture;

  Future<void> _signOut() async {
    await ProfileService.instance.signOut();
    if (!mounted) return;
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.loginScreen,
      (route) => false,
    );
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _historyFuture = MovieHistoryService.instance.loadHistory();
    _watchListSubscription = WatchListService.instance
        .watchSavedMovies()
        .listen(
          (movies) {
            if (!mounted) return;
            setState(() {
              _watchListMovies = movies;
              _watchListError = null;
            });
          },
          onError: (Object error) {
            if (!mounted) return;
            setState(() => _watchListError = error);
          },
        );
    _loadProfile();
  }

  @override
  void dispose() {
    _watchListSubscription.cancel();
    _tabController.dispose();
    super.dispose();
  }

  void _reloadHistory() {
    setState(() {
      _historyFuture = MovieHistoryService.instance.loadHistory();
    });
  }

  Future<void> _loadProfile() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    Map<String, dynamic> profile;
    try {
      profile = await ProfileService.instance.loadProfile();
    } catch (_) {
      return;
    }
    if (!mounted) return;
    setState(() {
      profileName =
          (profile['name'] as String?) ?? user.displayName ?? profileName;
      profileAvatar = (profile['avatar'] as String?) ?? profileAvatar;
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = context.height;
    var width = context.width;
    final loc = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppColors.darkBlackColor,
      body: Container(
        color: AppColors.greyColor,
        child: Column(
          children: [
            SizedBox(height: SizeConfig.height(context) * 0.05),
            Padding(
              padding: EdgeInsets.all(width * 0.035),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(40),
                          child: Image.asset(
                            profileAvatar,
                            height: height * 0.118,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(profileName, style: AppStyles.bold20White),
                      ],
                    ),
                  ),
                  FutureBuilder<List<Movie>>(
                    future: _historyFuture,
                    builder: (context, historySnapshot) {
                      return CustomColumn(
                        label_1: loc.watch_List,
                        label_2: loc.history,
                        count_1: _watchListMovies.length,
                        count_2: historySnapshot.data?.length ?? 0,
                      );
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.035),
              child: Row(
                spacing: 10,
                children: [
                  Expanded(
                    flex: 3,
                    child: CustomElevatedButton(
                      onPressedButton2: () async {
                        final updated = await Navigator.pushNamed(
                          context,
                          AppRoutes.updateProfileScreen,
                        );
                        if (updated == true && mounted) _loadProfile();
                      },
                      title: loc.edit_Profile,
                      style: AppStyles.regular20White,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: CustomElevatedButton(
                      isExitButton: true,
                      bgColor: AppColors.redColor,
                      onPressedButton2: _signOut,
                      title: loc.exit,
                      style: AppStyles.regular20White,
                      child: SvgPicture.asset(AppAssets.exitIcon),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: SizeConfig.height(context) * 0.02),
            TabBar(
              controller: _tabController,
              labelPadding: .only(bottom: height * 0.012),
              dividerColor: Colors.transparent,
              unselectedLabelColor: AppColors.primaryColor,
              indicatorColor: AppColors.primaryColor,
              indicatorSize: .tab,
              tabs: [
                Tab(
                  icon: const Icon(Icons.list, size: 40),
                  child: Text(loc.watch_List, style: AppStyles.bold18White),
                ),
                Tab(
                  icon: const Icon(Icons.folder, size: 40),
                  child: Text(loc.history, style: AppStyles.bold18White),
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  Builder(
                    builder: (context) {
                      if (_watchListError != null) {
                        return Center(
                          child: Text(
                            'Unable to load watch list',
                            style: AppStyles.regular16White,
                          ),
                        );
                      }
                      final movies = _watchListMovies;
                      return Container(
                        width: double.infinity,
                        color: AppColors.blackColor,
                        child: movies.isEmpty
                            ? Center(
                                child: Image.asset(AppAssets.emptyListImage),
                              )
                            : GridView.builder(
                                padding: EdgeInsets.symmetric(
                                  horizontal: width * 0.035,
                                  vertical: height * 0.012,
                                ),
                                itemCount: movies.length,
                                itemBuilder: (context, index) {
                                  final movie = movies[index];
                                  return InkWell(
                                    onTap: () async {
                                      if (movie.id == null) return;
                                      await Navigator.pushNamed(
                                        context,
                                        AppRoutes.movieDetailsScreen,
                                        arguments: movie.id,
                                      );
                                      if (mounted) _reloadHistory();
                                    },
                                    child: MovieCardItem(
                                      movieImage: movie.mediumCoverImage ?? '',
                                      movieRate: movie.rating,
                                      isSuggestion: true,
                                    ),
                                  );
                                },
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 12,
                                      crossAxisSpacing: 12,
                                      childAspectRatio: 0.7,
                                    ),
                              ),
                      );
                    },
                  ),
                  Container(
                    width: double.infinity,
                    color: AppColors.blackColor,
                    child: FutureBuilder<List<Movie>>(
                      future: _historyFuture,
                      builder: (context, snapshot) {
                        if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return Center(
                            child: Image.asset(AppAssets.emptyListImage),
                          );
                        }
                        return HistoryView(
                          movies: snapshot.data!,
                          onMovieTap: (movieId) async {
                            await Navigator.pushNamed(
                              context,
                              AppRoutes.movieDetailsScreen,
                              arguments: movieId,
                            );
                            if (mounted) _reloadHistory();
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
