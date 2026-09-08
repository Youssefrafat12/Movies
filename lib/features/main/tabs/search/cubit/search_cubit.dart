import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/features/main/tabs/search/cubit/search_state.dart';
import '../../../../../api/api_manager.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitialState());

  void getInitialMovies() async {
    emit(SearchLoadingState());
    try {
      var result = await ApiManager.getMoviesByGenre("");
      if (isClosed) return;
      emit(SearchSuccessState(result.data?.movies ?? []));
    } catch (e) {
      if (isClosed) return;
      emit(SearchErrorState(e.toString()));
    }
  }

  void searchMovies(String query) async {
    if (query.trim().isEmpty) {
      // getInitialMovies();
      emit(SearchInitialState());
      return;
    }
    emit(SearchLoadingState());
    try {
      var result = await ApiManager.searchMovies(query);
      if (isClosed) return;
      emit(SearchSuccessState(result.data?.movies ?? []));
    } catch (e) {
      if (isClosed) return;
      emit(SearchErrorState(e.toString()));
    }
  }
}
