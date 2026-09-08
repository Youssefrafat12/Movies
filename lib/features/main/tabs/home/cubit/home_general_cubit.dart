import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/api/api_manager.dart';
import 'home_general_state.dart';

class HomeGeneralCubit extends Cubit<HomeGeneralState> {
  HomeGeneralCubit() : super(HomeGeneralInitialState()) {
    getMoviesGeneral();
  }

  int selectedMovieIndex = 0;

  void changeSelectedMovie(int index) {
    selectedMovieIndex = index;
    if (state is HomeGeneralSuccessState) {
      emit(HomeGeneralSuccessState((state as HomeGeneralSuccessState).moviesList));
    }
  }

  void getMoviesGeneral() async {
    emit(HomeGeneralLoadingState());
    try {
      var response = await ApiManager.getMoviesByGenre("");
      if (response.status == "error") {
        emit(HomeGeneralErrorState(response.message ?? "Error occurred"));
      } else {
        emit(HomeGeneralSuccessState(response.data?.movies ?? []));
      }
    } catch (e) {
      emit(HomeGeneralErrorState(e.toString()));
    }
  }
}