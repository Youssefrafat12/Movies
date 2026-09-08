import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/features/main/tabs/browse/cubit/browse_state.dart';
import 'package:movies_app/features/main/tabs/browse/cubit/browse_view_model.dart';
import 'package:movies_app/features/main/tabs/browse/widgets/tab_bar_widget.dart';

class BrowseTab extends StatelessWidget {
  final String? initialGenre;

  const BrowseTab({super.key, this.initialGenre});

  @override
  Widget build(BuildContext context) {
    final routeGenre = ModalRoute.of(context)?.settings.arguments;
    final requestedGenre = initialGenre ??
        (routeGenre is String && routeGenre.isNotEmpty ? routeGenre : null);

    return BlocProvider(
      create: (context) =>
          BrowseViewModel(initialGenre: requestedGenre)..getAllMoviesAndGenres(),
      child: BlocBuilder<BrowseViewModel, BrowseState>(
        builder: (context, state) {
          var viewModel = BlocProvider.of<BrowseViewModel>(context);
          if (state is BrowseErrorState) {
            return Center(child: Text(state.statusMessage ?? 'Unknown Error'));
          }
          return TabBarWidget(
            genres: viewModel.genresList,
            movies: viewModel.filteredMovies,
            selectedGenre: viewModel.selectedGenre,
            isLoading: state is BrowseLoadingState,
            onGenreSelected: (genre) {
              viewModel.filterMoviesByGenre(genre);
            },
          );
        },
      ),
    );
  }
}
