import 'package:flutter/material.dart';
import 'package:movies_app/api/model/movie_details_response/movie.dart';
import 'package:movies_app/l10n/app_localizations.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_styles.dart';
import 'package:movies_app/utils/size_utils.dart';
import 'package:movies_app/utils/localized_genre.dart';

class MovieGeners extends StatelessWidget {
  final Movie movieDetails;
  const MovieGeners({super.key, required this.movieDetails});

  @override
  Widget build(BuildContext context) {
    var height = context.height;
    var width = context.width;
    return Column(
      children: [
        Row(
          children: [
            Text(
              AppLocalizations.of(context)!.genres,
              style: AppStyles.bold24White,
            ),
          ],
        ),
        SizedBox(height: height * 0.016),
        GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: movieDetails.genres!.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 28 / 8,
            mainAxisSpacing: height * 0.011,
            crossAxisSpacing: width * 0.035,
          ),
          itemBuilder: (context, index) {
            return Container(
              alignment: .center,
              decoration: BoxDecoration(
                borderRadius: .circular(12),
                color: AppColors.darkGreyColor,
              ),
              child: Text(
                localizedGenre(context, movieDetails.genres![index]),
                style: AppStyles.regular16White,
              ),
            );
          },
        ),
      ],
    );
  }
}
