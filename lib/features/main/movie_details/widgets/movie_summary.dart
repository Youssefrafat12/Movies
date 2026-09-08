import 'package:flutter/material.dart';
import 'package:movies_app/api/model/movie_details_response/movie.dart';
import 'package:movies_app/l10n/app_localizations.dart';
import 'package:movies_app/services/movie_translation_service.dart';
import 'package:movies_app/utils/app_styles.dart';
import 'package:movies_app/utils/size_utils.dart';

class MovieSummary extends StatefulWidget {
  final Movie movieDetails;
  const MovieSummary({super.key, required this.movieDetails});

  @override
  State<MovieSummary> createState() => _MovieSummaryState();
}

class _MovieSummaryState extends State<MovieSummary> {
  Future<String?>? _translatedSummary;
  String? _lastLanguageCode;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final languageCode = Localizations.localeOf(context).languageCode;
    if (_lastLanguageCode != languageCode) {
      _lastLanguageCode = languageCode;
      _translatedSummary = _translateSummary(languageCode);
    }
  }

  @override
  void didUpdateWidget(covariant MovieSummary oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.movieDetails.descriptionFull !=
        widget.movieDetails.descriptionFull) {
      _translatedSummary = _translateSummary(_lastLanguageCode ?? 'en');
    }
  }

  Future<String?> _translateSummary(String languageCode) {
    final summary = widget.movieDetails.descriptionFull ?? '';
    if (languageCode != 'ar' || summary.isEmpty) {
      return Future.value(null);
    }
    return MovieTranslationService.instance.translateToArabic(summary);
  }

  @override
  Widget build(BuildContext context) {
    var height = context.height;
    return Column(
      children: [
        Row(
          children: [
            Text(
              AppLocalizations.of(context)!.summary,
              style: AppStyles.bold24White,
            ),
          ],
        ),
        SizedBox(height: height * 0.016),
        FutureBuilder<String?>(
          future: _translatedSummary,
          builder: (context, snapshot) {
            return Text(
              snapshot.data ?? widget.movieDetails.descriptionFull ?? '',
              style: AppStyles.regular16White,
            );
          },
        ),
      ],
    );
  }
}
