import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/api/api_manager.dart';
import 'package:movies_app/api/model/movie_details_response/movie.dart';
import 'browse_state.dart';

class BrowseViewModel extends Cubit<BrowseState> {
  final String? initialGenre;

  BrowseViewModel({this.initialGenre}) : super(BrowseInitialState());

  List<Movie> filteredMovies = [];
  Set<String> uniqueGenres = {'All'};
  List<String> genresList = [];
  String selectedGenre = 'All';

  // أول ما الصفحة تفتح تجيب كل الأفلام وتستخرج التصنيفات ديناميكياً
  void getAllMoviesAndGenres() async {
    emit(BrowseLoadingState());
    try {
      var response = await ApiManager.getAllMovie();
      var rawList = response.data?.movies ?? [];

      var allMovies = (rawList as List<dynamic>?)
          ?.map((e) => e is Movie ? e : Movie.fromJson(e.toJson()))
          .toList() ??
          [];

      uniqueGenres = {'All'};
      for (var movie in allMovies) {
        if (movie.genres != null) {
          for (var genre in movie.genres!) {
            uniqueGenres.add(genre);
          }
        }
      }
      genresList = uniqueGenres.toList();
      if (initialGenre != null && uniqueGenres.contains(initialGenre)) {
        selectedGenre = initialGenre!;
        filteredMovies = allMovies
            .where((movie) => movie.genres?.contains(initialGenre) ?? false)
            .toList();
      } else {
        filteredMovies = allMovies;
      }

      emit(BrowseSuccessState());
    } catch (e) {
      emit(BrowseErrorState(statusMessage: e.toString()));
    }
  }

  // لما المستخدم يختار تصنيف معين، نستخدم الـ Query Parameter من الـ API
  void filterMoviesByGenre(String genre) async {
    selectedGenre = genre;
    emit(BrowseLoadingState());
    try {
      dynamic response;
      if (genre == 'All') {
        response = await ApiManager.getAllMovie();
      } else {
        response = await ApiManager.getMoviesByGenre(genre);
      }

      var rawList = response.data?.movies ?? [];

      filteredMovies = (rawList as List<dynamic>?)
          ?.map((e) => e is Movie ? e : Movie.fromJson(e.toJson()))
          .toList() ??
          [];

      emit(BrowseSuccessState());
    } catch (e) {
      emit(BrowseErrorState(statusMessage: e.toString()));
    }
  }
}