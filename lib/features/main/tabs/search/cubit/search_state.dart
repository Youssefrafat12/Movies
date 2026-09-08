import 'package:movies_app/api/model/movie_list/movies.dart';


abstract class SearchState {}

class SearchInitialState extends SearchState {}

class SearchLoadingState extends SearchState {}

class SearchErrorState extends SearchState {
  final String errorMessage;
  SearchErrorState(this.errorMessage);
}

class SearchSuccessState extends SearchState {
  final List<Movies> moviesList;
  SearchSuccessState(this.moviesList);
}