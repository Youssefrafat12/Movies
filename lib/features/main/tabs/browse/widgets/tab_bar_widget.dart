import 'package:flutter/material.dart';
import 'package:movies_app/api/model/movie_details_response/movie.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_routes.dart';
import 'package:movies_app/utils/app_styles.dart';
import 'package:movies_app/utils/size_utils.dart';
import 'package:movies_app/widgets/movie_card_item.dart';
import 'package:movies_app/widgets/skeleton/movie_grid_skeleton.dart';
import 'package:movies_app/utils/localized_genre.dart';

class TabBarWidget extends StatefulWidget {
  final List<String> genres;
  final List<Movie> movies;
  final String selectedGenre;
  final bool isLoading;
  final Function(String) onGenreSelected;

  const TabBarWidget({
    super.key,
    required this.genres,
    required this.movies,
    required this.selectedGenre,
    required this.isLoading,
    required this.onGenreSelected,
  });

  @override
  State<TabBarWidget> createState() => _TabBarWidgetState();
}

class _TabBarWidgetState extends State<TabBarWidget> {
  final Map<String, GlobalKey> _genreKeys = {};

  @override
  void didUpdateWidget(covariant TabBarWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedGenre != widget.selectedGenre ||
        oldWidget.genres != widget.genres) {
      _scrollSelectedGenreIntoView();
    }
  }

  void _scrollSelectedGenreIntoView() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final selectedKey = _genreKeys[widget.selectedGenre];
      if (!mounted || selectedKey == null || selectedKey.currentContext == null) {
        return;
      }
      Scrollable.ensureVisible(
        selectedKey.currentContext!,
        alignment: 0.5,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = context.height;
    var width = context.width;
    _scrollSelectedGenreIntoView();

    return SafeArea(
      bottom: false,
      child: Scaffold(
        backgroundColor: AppColors.blackColor,
        body: SingleChildScrollView(
          padding: EdgeInsets.only(bottom: height * 0.1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: height * 0.012),
              SizedBox(
                height: 55,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                  children: widget.genres.map((genre) {
                    bool isSelected = widget.selectedGenre == genre;
                    final genreKey = _genreKeys.putIfAbsent(
                      genre,
                      GlobalKey.new,
                    );

                    return Padding(
                      key: genreKey,
                      padding: EdgeInsets.symmetric(horizontal: width * 0.012),
                      child: GestureDetector(
                        onTap: () {
                          widget.onGenreSelected(genre);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(
                            horizontal: width * 0.035,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.primaryColor
                                : Colors.transparent,
                            border: Border.all(
                              color: AppColors.primaryColor,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            localizedGenre(context, genre),
                            style: isSelected
                                ? AppStyles.bold20DarkBlack
                                : AppStyles.bold20Primary,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: SizeConfig.height(context) * 0.025),
                  widget.isLoading
                  ? const MovieGridSkeleton()
                  : widget.movies.isEmpty
                  ? const Padding(
                      padding: EdgeInsets.only(top: 100),
                      child: Center(
                        child: Text(
                          'No movies found for this category',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    )
                  : GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.symmetric(horizontal: width * 0.035),
                      itemCount: widget.movies.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 12,
                            crossAxisSpacing: 12,
                            childAspectRatio: 0.7,
                          ),
                      itemBuilder: (context, index) {
                        var movie = widget.movies[index];
                        return InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              AppRoutes.movieDetailsScreen,
                              arguments: movie.id,
                            );
                          },
                          child: MovieCardItem(
                            movie: movie,
                            movieImage:
                                movie.mediumCoverImage ??
                                movie.largeCoverImage ??
                                movie.backgroundImage ??
                                '',
                            movieRate: movie.rating,
                          ),
                        );
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
