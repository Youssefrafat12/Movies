import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/api/api_manager.dart';
import 'package:movies_app/features/main/movie_details/cubit/movie_details_state.dart';

class MovieDetailsViewModel extends Cubit<MovieDetailsState> {
  MovieDetailsViewModel() : super(MovieDetailsLoadingState());

  void getMovieDetails(int movieId) async {
    try {
      emit(MovieDetailsLoadingState());

      var response = await ApiManager.getMovieDetails(movieId);

      if (response.status == 'error') {
        emit(MovieDetailsErrorState(statusMessage: response.statusMessage));
      } else {
        emit(MovieDetailsSuccessState(moviesList: response.data!.movie));
      }
    } catch (e) {
      emit(MovieDetailsErrorState(statusMessage: e.toString()));
    }
  }
}
