import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/api/api_manager.dart';
import 'package:movies_app/api/model/movie_list/movies.dart';

class HomeTabViewModel extends ChangeNotifier {
  List<Movies>? moviesList;
  String? errorMessage;
  bool? isLoading = false;

  void getMoviesByGenre(String genre) async {
    isLoading = true;
    notifyListeners();
    try {
      var movieResponse = await ApiManager.getMoviesByGenre(genre);
      if (movieResponse.status == "error") {
        errorMessage = movieResponse.message;
        isLoading = false;
      } else {
        moviesList = movieResponse.data!.movies;
        isLoading = false;
      }
    } catch (e) {
      errorMessage = e.toString();
    }
    isLoading = false;
    notifyListeners();
  }
}
