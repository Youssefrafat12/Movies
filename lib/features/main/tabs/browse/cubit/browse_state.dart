abstract class BrowseState {}

class BrowseInitialState extends BrowseState {}

class BrowseLoadingState extends BrowseState {}

class BrowseErrorState extends BrowseState {
  final String? statusMessage;
  BrowseErrorState({required this.statusMessage});
}

class BrowseSuccessState extends BrowseState {}

class BrowseFilterChangedState extends BrowseState {}