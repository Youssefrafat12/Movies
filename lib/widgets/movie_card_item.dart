import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies_app/utils/app_assets.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_styles.dart';
import 'package:movies_app/utils/size_utils.dart';
import 'package:movies_app/utils/movie_image_url.dart';

class MovieCardItem extends StatelessWidget {
  final dynamic movie;
  final String? movieImage;
  final Object? movieRate;
  final bool isSuggestion;

  const MovieCardItem({
    super.key,
    this.movie,
    this.movieImage,
    this.movieRate,
    this.isSuggestion = false,
  });

  @override
  Widget build(BuildContext context) {
    var height = context.height;
    var width = context.width;
    final imageUrl = movieImageUrl(
      isSuggestion ? movieImage : movie?.mediumCoverImage,
    );
    final hasImage = imageUrl.isNotEmpty;
    final rating = isSuggestion ? movieRate : movie?.rating;
    final ratingLabel = rating is num && rating <= 0
      ? 'N/A'
      : rating?.toString() ?? 'N/A';

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Stack(
        fit: StackFit.expand,
        children: [
          hasImage
              ? CachedNetworkImage(
                  imageUrl: imageUrl,
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) =>
                      Image.asset(AppAssets.movieImage, fit: BoxFit.cover),
                )
              : Image.asset(AppAssets.movieImage, fit: BoxFit.cover),
          Align(
            alignment: AlignmentDirectional.topStart,
            child: Container(
              margin: EdgeInsetsDirectional.only(
                start: width * 0.02,
                top: width * 0.03,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.02,
                vertical: height * 0.005,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.blackColor.withValues(alpha: 0.71),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    ratingLabel,
                    style: AppStyles.regular16White,
                  ),
                  SizedBox(width: width * 0.01),
                  SvgPicture.asset(
                    AppAssets.rateIcon,
                    width: width * 0.034,
                    height: height * 0.015,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}