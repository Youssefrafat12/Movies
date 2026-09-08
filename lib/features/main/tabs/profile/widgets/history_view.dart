import 'package:flutter/material.dart';
import 'package:movies_app/api/model/movie_details_response/movie.dart';
import 'package:movies_app/utils/size_utils.dart';
import 'package:movies_app/widgets/movie_card_item.dart';

class HistoryView extends StatelessWidget {
  final List<Movie> movies;
  final ValueChanged<int> onMovieTap;

  const HistoryView({
    super.key,
    required this.movies,
    required this.onMovieTap,
  });

  @override
  Widget build(BuildContext context) {
    final width = context.width;
    final height = context.height;
    final moviesWithIds = movies.where((movie) => movie.id != null).toList();
    return GridView.builder(
      padding: EdgeInsets.all(width * 0.035),
      itemCount: moviesWithIds.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: width * 0.04,
        mainAxisSpacing: height * 0.016,
        childAspectRatio: 189 / 279,
      ),
      itemBuilder: (context, index) {
        final movie = moviesWithIds[index];
        return InkWell(
          onTap: () => onMovieTap(movie.id!),
          borderRadius: BorderRadius.circular(20),
          child: MovieCardItem(
            isSuggestion: true,
            movieImage: movie.mediumCoverImage,
            movieRate: movie.rating,
          ),
        );
      },
    );
  }
}
