import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/features/main/movie_details/movie_suggestions/cubit/movie_suggestion_state.dart';
import 'package:movies_app/features/main/movie_details/movie_suggestions/cubit/movie_suggestion_view_model.dart';
import 'package:movies_app/features/main/movie_details/movie_suggestions/movie_suggestion_view.dart';
import 'package:movies_app/utils/app_routes.dart';
import 'package:movies_app/widgets/main_error.dart';
import 'package:movies_app/widgets/skeleton/movie_grid_skeleton.dart';

class MovieSuggestionBlocBuilder extends StatefulWidget {
  final int movieId;
  const MovieSuggestionBlocBuilder({super.key, required this.movieId});

  @override
  State<MovieSuggestionBlocBuilder> createState() =>
      _MovieSuggestionBlocBuilderState();
}

class _MovieSuggestionBlocBuilderState
    extends State<MovieSuggestionBlocBuilder> {
  @override
  void initState() {
    super.initState();
    context.read<MovieSuggestionViewModel>().getMovieSuggestions(
      widget.movieId,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieSuggestionViewModel, MovieSuggestionState>(
      builder: (context, state) {
        if (state is MovieSuggestionLoadingState) {
          return MovieGridSkeleton();
        } else if (state is MovieSuggestionErrorState) {
          return MainError(
            onPressed: () {},
            onTap: () {
              context.read<MovieSuggestionViewModel>().getMovieSuggestions(
                widget.movieId,
              );
            },
          );
        } else if (state is MovieSuggestionSuccessState) {
          var data = state.moviesSuggestionList;
          return MovieSuggestionView(
            onMovieTap: (movieId) {
              Navigator.pushNamed(
                context,
                AppRoutes.movieDetailsScreen,
                arguments: movieId,
              );
            },
            movieSuggestion: data,
          );
        }
        return Container();
      },
    );
  }
}
