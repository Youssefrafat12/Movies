import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies_app/l10n/app_localizations.dart';
import 'package:movies_app/utils/app_assets.dart';
import 'package:movies_app/utils/size_utils.dart';
import 'package:movies_app/widgets/custom_text_field.dart';
import 'package:movies_app/widgets/skeleton/movie_grid_skeleton.dart';
import '../../../../utils/app_routes.dart';
import '../../../../widgets/movie_card_item.dart';
import 'cubit/search_cubit.dart';
import 'cubit/search_state.dart';

class SearchTab extends StatelessWidget {
  SearchTab({super.key});
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var width = context.width;
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: Builder(
        builder: (context) {
          return SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.035),
              child: Column(
                children: [
                  CustomTextField(
                    controller: controller,
                    title: AppLocalizations.of(context)!.search,
                    prefix: Padding(
                      padding: EdgeInsetsDirectional.only(start: width * 0.025),
                      child: SvgPicture.asset(AppAssets.searchIcon),
                    ),
                    onChanged: (text) {
                      context.read<SearchCubit>().searchMovies(text);
                    },
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: BlocBuilder<SearchCubit, SearchState>(
                      builder: (context, state) {
                        if (state is SearchInitialState) {
                          return Image.asset(AppAssets.emptyListImage);
                        } else if (state is SearchLoadingState) {
                          return MovieGridSkeleton();
                        } else if (state is SearchErrorState) {
                          return Center(
                            child: Text(
                              state.errorMessage,
                              style: const TextStyle(color: Colors.white),
                            ),
                          );
                        } else if (state is SearchSuccessState) {
                          var movies = state.moviesList;
                          if (movies.isEmpty) {
                            return Center(
                              child: Text(
                                AppLocalizations.of(context)!.no_movies_found,
                                style: TextStyle(color: Colors.white),
                              ),
                            );
                          }
                          return GridView.builder(
                            padding: EdgeInsets.symmetric(
                              horizontal: width * 0.016,
                            ),
                            itemCount: movies.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 12,
                                  crossAxisSpacing: 12,
                                  childAspectRatio: 0.7,
                                ),
                            itemBuilder: (context, index) {
                              var movie = movies[index];
                              return InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    AppRoutes.movieDetailsScreen,
                                    arguments: movies[index].id,
                                  );
                                },
                                child: MovieCardItem(
                                  movie: movie,
                                  movieImage: movie.mediumCoverImage,
                                  movieRate: movie.rating?.toDouble(),
                                ),
                              );
                            },
                          );
                        }
                        return SizedBox();
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
