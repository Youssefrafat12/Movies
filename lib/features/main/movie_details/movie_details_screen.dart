import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:movies_app/api/model/movie_details_response/movie.dart';
import 'package:movies_app/api/model/movie_suggestions_response/movie_suggestion.dart';
import 'package:movies_app/features/main/movie_details/movie_suggestions/widgets/movie_suggestion_bloc_builder.dart';
import 'package:movies_app/features/main/movie_details/widgets/movie_cast.dart';
import 'package:movies_app/features/main/movie_details/widgets/movie_geners.dart';
import 'package:movies_app/features/main/movie_details/widgets/movie_head.dart';
import 'package:movies_app/features/main/movie_details/widgets/movie_info.dart';
import 'package:movies_app/features/main/movie_details/widgets/movie_screen_shots.dart';
import 'package:movies_app/features/main/movie_details/widgets/movie_summary.dart';
import 'package:movies_app/features/main/movie_details/widgets/movie_web_view.dart';
import 'package:movies_app/features/main/tabs/profile/watch/watch_list_service.dart';
import 'package:movies_app/l10n/app_localizations.dart';
import 'package:movies_app/utils/app_assets.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_styles.dart';
import 'package:movies_app/utils/size_utils.dart';
import 'package:movies_app/utils/movie_image_url.dart';
import 'package:movies_app/widgets/custom_elevated_button.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MovieDetailsScreen extends StatefulWidget {
  final Movie? movieDetails;
  final List<MovieSuggestion>? movieSuggestion;

  const MovieDetailsScreen({
    super.key,
    this.movieSuggestion,
    this.movieDetails,
  });

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  late YoutubePlayerController _playerController;
  bool isSaved = false;

  @override
  void initState() {
    super.initState();
    _checkIfSaved();
  }

  Future<void> _checkIfSaved() async {
    final saved = await WatchListService.instance.isSaved(
      widget.movieDetails?.id,
    );
    if (mounted) setState(() => isSaved = saved);
  }

  Future<void> _toggleSave() async {
    if (widget.movieDetails == null) return;
    final newState = await WatchListService.instance.toggleSave(
      widget.movieDetails!,
    );
    if (mounted) setState(() => isSaved = newState);
  }

  @override
  Widget build(BuildContext context) {
    var height = context.height;
    var width = context.width;
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                Stack(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: height * 0.55,
                      child: CachedNetworkImage(
                        imageUrl: movieImageUrl(
                          widget.movieDetails!.mediumCoverImage,
                        ),
                        fit: BoxFit.cover,
                        alignment: Alignment.topCenter,
                        errorWidget: (context, url, error) => Image.asset(
                          AppAssets.movieDetailsImage,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: height * 0.55,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            AppColors.blackColor.withValues(alpha: 0.2),
                            AppColors.blackColor.withValues(alpha: 0.7),
                            AppColors.blackColor,
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.035),
              child: SafeArea(
                child: Column(
                  children: [
                    MovieHead(
                      onIconWatchButton: showTrailer,
                      onBookmarkButton: _toggleSave,
                      isSaved: isSaved,
                      movieName: widget.movieDetails!.title!,
                      movieTime: widget.movieDetails!.year!,
                    ),
                    SizedBox(height: height * 0.016),
                    CustomElevatedButton(
                      onPressedButton2: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return MovieWebView(
                                url: widget.movieDetails!.url!,
                              );
                            },
                          ),
                        );
                      },
                      title: AppLocalizations.of(context)!.watch,
                      style: AppStyles.bold24White,
                      bgColor: AppColors.redColor,
                    ),
                    SizedBox(height: height * 0.016),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MovieInfo(
                          text: widget.movieDetails!.likeCount!,
                          icon: AppAssets.favoriteIcon,
                        ),
                        MovieInfo(
                          text: widget.movieDetails!.runtime!,
                          icon: AppAssets.timeIcon,
                        ),
                        MovieInfo(
                          text: widget.movieDetails!.rating != null &&
                                  widget.movieDetails!.rating! > 0
                              ? widget.movieDetails!.rating!
                              : AppLocalizations.of(context)!.not_available,
                          icon: AppAssets.rateIcon,
                        ),
                      ],
                    ),
                    SizedBox(height: height * 0.016),
                    MovieScreenShots(movieDetails: widget.movieDetails!),
                    SizedBox(height: height * 0.024),
                    Row(
                      children: [
                        Text(
                          AppLocalizations.of(context)!.similar,
                          style: AppStyles.bold24White,
                        ),
                      ],
                    ),
                    SizedBox(height: height * 0.016),
                    MovieSuggestionBlocBuilder(
                      movieId: widget.movieDetails!.id!,
                    ),
                    SizedBox(height: height * 0.024),
                    MovieSummary(movieDetails: widget.movieDetails!),
                    SizedBox(height: height * 0.024),
                    MovieCast(movieDetails: widget.movieDetails!),
                    SizedBox(height: height * 0.024),
                    MovieGeners(movieDetails: widget.movieDetails!),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showTrailer() {
    final videoId = YoutubePlayerController.convertUrlToId(
      'https://www.youtube.com/watch?v=${widget.movieDetails!.ytTrailerCode}',
    );
    if (videoId == null || videoId.isEmpty) return;

    _playerController = YoutubePlayerController.fromVideoId(
      videoId: videoId,
      autoPlay: true,
    );
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: AppColors.transparentColor,
          child: YoutubePlayer(controller: _playerController),
        );
      },
    ).then((value) {
      _playerController.close();
    });
  }
}
