import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/api/api_manager.dart';
import 'package:movies_app/features/main/tabs/home/cubit/home_genre_state.dart';

class HomeGenreCubit extends Cubit<HomeGenreState> {
  HomeGenreCubit() : super(HomeGenreInitialState());

  void getMoviesByGenre(String genre) async {
    if (isClosed) return;
    emit(HomeGenreLoadingState());
    try {
      var response = await ApiManager.getMoviesByGenre(genre);
      if (isClosed) return;
      if (response.status == "error") {
        emit(HomeGenreErrorState(response.message ?? "Error occurred"));
      } else {
        emit(HomeGenreSuccessState(response.data?.movies ?? []));
      }
    } catch (e) {
      if (isClosed) return;
      emit(HomeGenreErrorState(e.toString()));
    }
  }
}