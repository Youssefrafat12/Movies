import 'package:movies_app/api/model/movie_suggestions_response/movie_suggestion.dart';

class MovieSuggestionState {}

class MovieSuggestionLoadingState extends MovieSuggestionState {}

class MovieSuggestionErrorState extends MovieSuggestionState {
  String? statusMessage;
  MovieSuggestionErrorState({required this.statusMessage});
}

class MovieSuggestionSuccessState extends MovieSuggestionState {
  List<MovieSuggestion>? moviesSuggestionList;

  MovieSuggestionSuccessState({required this.moviesSuggestionList});
}
