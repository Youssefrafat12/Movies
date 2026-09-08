import 'package:cached_network_image/cached_network_image.dart';
import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/features/main/tabs/home/cubit/home_general_cubit.dart';
import 'package:movies_app/features/main/tabs/home/cubit/home_general_state.dart';
import 'package:movies_app/features/main/tabs/home/widgets/home_tab_widget_by_genre.dart';
import 'package:movies_app/utils/app_routes.dart';
import 'package:movies_app/widgets/main_error.dart';
import 'package:movies_app/widgets/skeleton/movie_carousel_skeleton.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../utils/app_assets.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_styles.dart';
import '../../../../utils/size_utils.dart';
import '../../../../widgets/movie_card_item.dart';
import '../../../../utils/localized_genre.dart';
import '../../../../utils/movie_image_url.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => HomeTabState();
}

class HomeTabState extends State<HomeTab> {
  List<String> availableGenres = [];
  String selectedGenre = '';

  @override
  void initState() {
    super.initState();
    final state = context.read<HomeGeneralCubit>().state;
    if (state is HomeGeneralSuccessState) {
      availableGenres = _genresFromMovies(state.moviesList);
      if (availableGenres.isNotEmpty) {
        selectedGenre = _randomGenre();
      }
    }
  }

  String _randomGenre() {
    return availableGenres[Random().nextInt(availableGenres.length)];
  }

  List<String> _genresFromMovies(List movies) {
    final genres = <String>{};
    for (var movie in movies) {
      for (var genre in movie.genres ?? <String>[]) {
        if (genre.toLowerCase() != 'horror') {
          genres.add(genre);
        }
      }
    }
    return genres.toList()..sort();
  }

  void _updateAvailableGenres(List movies) {
    final genres = _genresFromMovies(movies);
    if (genres.length == availableGenres.length &&
        genres.every(availableGenres.contains)) {
      return;
    }

    setState(() {
      availableGenres = genres;
      selectedGenre = genres.isEmpty ? '' : _randomGenre();
    });
  }

  void refreshGenre() {
    if (availableGenres.isNotEmpty) {
      setState(() => selectedGenre = _randomGenre());
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = context.width;
    var height = context.height;

    return BlocConsumer<HomeGeneralCubit, HomeGeneralState>(
      listener: (context, state) {
        if (state is HomeGeneralSuccessState) {
          _updateAvailableGenres(state.moviesList);
        }
      },
      builder: (context, state) {
        var cubit = context.read<HomeGeneralCubit>();
        String? bgImage;

        if (state is HomeGeneralSuccessState && state.moviesList.isNotEmpty) {
          var movie = state.moviesList[cubit.selectedMovieIndex];
          bgImage = movie.largeCoverImage ?? movie.mediumCoverImage;
        }
        return Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: height * 0.65,
              child: CachedNetworkImage(
                imageUrl: movieImageUrl(bgImage),
                errorWidget: (context, url, error) {
                  return Icon(Icons.error);
                },
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
              ),
            ),
            Positioned.fill(
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black45,
                      Colors.black26,
                      Color(0xFF121312),
                      Color(0xFF121312),
                    ],
                    stops: [0.0, 0.35, 0.65, 1.0],
                  ),
                ),
              ),
            ),
            SingleChildScrollView(
              padding: EdgeInsets.only(bottom: height * 0.1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: height * 0.01),
                  Image.asset(AppAssets.availableNowImage),
                  SizedBox(height: height * 0.02),
                  if (state is HomeGeneralLoadingState ||
                      state is HomeGeneralInitialState)
                    const MovieCarouselSkeleton()
                  else if (state is HomeGeneralErrorState)
                    MainError(
                      errorMessage: state.errorMessage,
                      onPressed: () {
                        context.read<HomeGeneralCubit>().getMoviesGeneral();
                      },
                      onTap: () {
                        context.read<HomeGeneralCubit>().getMoviesGeneral();
                      },
                    )
                  else if (state is HomeGeneralSuccessState)
                      SizedBox(
                        height: height * 0.36,
                        child: CarouselSlider.builder(
                          itemCount: state.moviesList.length,
                          itemBuilder: (context, index, realIndex) {
                            return SizedBox(
                              width: width * 0.5,
                              child: InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    AppRoutes.movieDetailsScreen,
                                    arguments: state.moviesList[index].id,
                                  );
                                },
                                child: MovieCardItem(
                                  movie: state.moviesList[index] as dynamic,
                                ),
                              ),
                            );
                          },
                          options: CarouselOptions(
                            autoPlay: true,
                            height: height * 0.36,
                            enlargeCenterPage: true,
                            viewportFraction: 0.5,
                            onPageChanged: (index, reason) {
                              context
                                  .read<HomeGeneralCubit>()
                                  .changeSelectedMovie(index);
                            },
                          ),
                        ),
                      ),
                  Image.asset(AppAssets.watchNowImage),
                  if (selectedGenre.isNotEmpty) ...[
                    Padding(
                      padding: EdgeInsetsDirectional.only(start: width * 0.035),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            localizedGenre(context, selectedGenre),
                            style: AppStyles.regular20White,
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                AppRoutes.mainScreen,
                                arguments: {
                                  'initialIndex': 2,
                                  'browseGenre': selectedGenre,
                                },
                              );
                            },
                            child: Row(
                              spacing: width * 0.01,
                              children: [
                                Text(
                                  AppLocalizations.of(context)!.see_More,
                                  style: AppStyles.regular16DarkPrimary,
                                ),
                                const Icon(
                                  Icons.arrow_forward,
                                  color: AppColors.primaryColor,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height * 0.22,
                      child: HomeTabWidgetByGenre(
                        key: ValueKey(selectedGenre),
                        genre: selectedGenre,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}