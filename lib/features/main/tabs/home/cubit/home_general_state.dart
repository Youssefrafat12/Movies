abstract class HomeGeneralState {}

class HomeGeneralInitialState extends HomeGeneralState {}
class HomeGeneralLoadingState extends HomeGeneralState {}
class HomeGeneralSuccessState extends HomeGeneralState {
  final List moviesList;
  HomeGeneralSuccessState(this.moviesList);
}
class HomeGeneralErrorState extends HomeGeneralState {
  final String errorMessage;
  HomeGeneralErrorState(this.errorMessage);
}