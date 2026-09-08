import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/api/api_manager.dart';
import 'package:movies_app/api/model/movie_list/movies.dart';

class HomeTabViewModelBottom extends ChangeNotifier {
  List<Movies>? actionMoviesList;
  String selectedGenre = "Action";
  String? errorMessage;
  bool? isLoading = false;

  void getMoviesByGenre(String genre) async {
    selectedGenre = genre;
    isLoading = true;
    notifyListeners();
    try {
      var response = await ApiManager.getMoviesByGenre(genre);
      if (response.status == "error") {
        errorMessage = response.message;
        isLoading = false;
      } else {
        actionMoviesList = response.data!.movies;
        isLoading = false;
      }
    } catch (e) {
      errorMessage = e.toString();
    }
    isLoading = false;
    notifyListeners();
  }
}
