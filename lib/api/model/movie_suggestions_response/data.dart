import 'movie_suggestion.dart';

class Data {
  int? movieCount;
  List<MovieSuggestion>? movies;

  Data({this.movieCount, this.movies});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    movieCount: json['movie_count'] as int?,
    movies: (json['movies'] as List<dynamic>?)
        ?.map((e) => MovieSuggestion.fromJson(e as Map<String, dynamic>))
        .toList(),
  );

  Map<String, dynamic> toJson() => {
    'movie_count': movieCount,
    'movies': movies?.map((e) => e.toJson()).toList(),
  };
}
