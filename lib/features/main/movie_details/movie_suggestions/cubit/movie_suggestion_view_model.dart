import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/api/api_manager.dart';
import 'package:movies_app/features/main/movie_details/movie_suggestions/cubit/movie_suggestion_state.dart';

class MovieSuggestionViewModel extends Cubit<MovieSuggestionState> {
  MovieSuggestionViewModel() : super(MovieSuggestionLoadingState());

  void getMovieSuggestions(int movieId) async {
    try {
      emit(MovieSuggestionLoadingState());
      var response = await ApiManager.getMovieSuggestions(movieId);
      if (response.status == 'error') {
        emit(MovieSuggestionErrorState(statusMessage: response.statusMessage));
      } else {
        emit(
          MovieSuggestionSuccessState(
            moviesSuggestionList: response.data!.movies,
          ),
        );
      }
    } catch (e) {
      emit(MovieSuggestionErrorState(statusMessage: e.toString()));
    }
  }
}
