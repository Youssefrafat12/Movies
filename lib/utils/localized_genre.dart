import 'package:flutter/widgets.dart';
import 'package:movies_app/l10n/app_localizations.dart';

String localizedGenre(BuildContext context, String genre) {
  final l10n = AppLocalizations.of(context)!;

  switch (genre.trim().toLowerCase().replaceAll('-', ' ').replaceAll('_', ' ')) {
    case 'all':
      return l10n.all_genres;
    case 'action':
      return l10n.action;
    case 'animation':
      return l10n.animation;
    case 'horror':
      return l10n.horror;
    case 'comedy':
      return l10n.comedy;
    case 'drama':
      return l10n.drama;
    case 'sci fi':
    case 'science fiction':
      return l10n.sci_fi;
    case 'fantasy':
      return l10n.fantasy;
    case 'romance':
      return l10n.romance;
    case 'crime':
      return l10n.crime;
    case 'adventure':
      return l10n.adventure;
    case 'biography':
      return l10n.biography;
    case 'documentary':
      return l10n.documentary;
    case 'family':
      return l10n.family;
    case 'history':
      return l10n.history_genre;
    case 'music':
      return l10n.music;
    case 'musical':
      return l10n.musical;
    case 'mystery':
      return l10n.mystery;
    case 'film noir':
      return l10n.film_noir;
    case 'sport':
      return l10n.sport;
    case 'thriller':
      return l10n.thriller;
    case 'talk show':
      return l10n.talk_show;
    case 'war':
      return l10n.war;
    case 'western':
      return l10n.western;
    default:
      return genre;
  }
}