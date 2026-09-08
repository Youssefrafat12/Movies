import 'package:movies_app/api/model/movie_list/movies.dart';

abstract class HomeGenreState {}

class HomeGenreInitialState extends HomeGenreState {}

class HomeGenreLoadingState extends HomeGenreState {}

class HomeGenreErrorState extends HomeGenreState {
  final String errorMessage;
  HomeGenreErrorState(this.errorMessage);
}

class HomeGenreSuccessState extends HomeGenreState {
  final List<Movies> moviesList;
  HomeGenreSuccessState(this.moviesList);
}
