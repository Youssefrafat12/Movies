import 'package:movies_app/api/model/movie_details_response/movie.dart';

class MovieDetailsState {}

class MovieDetailsLoadingState extends MovieDetailsState {}

class MovieDetailsErrorState extends MovieDetailsState {
  String? statusMessage;
  MovieDetailsErrorState({required this.statusMessage});
}

class MovieDetailsSuccessState extends MovieDetailsState {
  Movie? moviesList;

  MovieDetailsSuccessState({required this.moviesList});
}
