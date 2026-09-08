import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @find_Your_Next.
  ///
  /// In en, this message translates to:
  /// **'Find Your Next\nFavorite Movie Here'**
  String get find_Your_Next;

  /// No description provided for @get_access_to_a_huge.
  ///
  /// In en, this message translates to:
  /// **'Get access to a huge library of movies to suit all tastes. You will surely like it.'**
  String get get_access_to_a_huge;

  /// No description provided for @explore_Now.
  ///
  /// In en, this message translates to:
  /// **'Explore Now'**
  String get explore_Now;

  /// No description provided for @discover_Movies.
  ///
  /// In en, this message translates to:
  /// **'Discover Movies'**
  String get discover_Movies;

  /// No description provided for @explore_a_vast_collection.
  ///
  /// In en, this message translates to:
  /// **'Explore a vast collection of movies in all qualities and genres. Find your next favorite film with ease.'**
  String get explore_a_vast_collection;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @explore_All_Genres.
  ///
  /// In en, this message translates to:
  /// **'Explore All Genres'**
  String get explore_All_Genres;

  /// No description provided for @discover_movies_from_every_genre.
  ///
  /// In en, this message translates to:
  /// **'Discover movies from every genre, in all available qualities. Find something new and exciting to watch every day.'**
  String get discover_movies_from_every_genre;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @create_Watchlists.
  ///
  /// In en, this message translates to:
  /// **'Create Watchlists'**
  String get create_Watchlists;

  /// No description provided for @save_movies_to_your_watchlist.
  ///
  /// In en, this message translates to:
  /// **'Save movies to your watchlist to keep track of what you want to watch next. Enjoy films in various qualities and genres.'**
  String get save_movies_to_your_watchlist;

  /// No description provided for @rate_Review.
  ///
  /// In en, this message translates to:
  /// **'Rate, Review, and Learn'**
  String get rate_Review;

  /// No description provided for @share_your_thoughts.
  ///
  /// In en, this message translates to:
  /// **'Share your thoughts on the movies you\'ve watched. Dive deep into film details and help others discover great movies with your reviews.'**
  String get share_your_thoughts;

  /// No description provided for @start_Watching_Now.
  ///
  /// In en, this message translates to:
  /// **'Start Watching Now'**
  String get start_Watching_Now;

  /// No description provided for @finish.
  ///
  /// In en, this message translates to:
  /// **'Finish'**
  String get finish;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @forget_Password.
  ///
  /// In en, this message translates to:
  /// **'Forget Password'**
  String get forget_Password;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @dont_Have_Account.
  ///
  /// In en, this message translates to:
  /// **'Don’t Have Account'**
  String get dont_Have_Account;

  /// No description provided for @create_One.
  ///
  /// In en, this message translates to:
  /// **'Create One'**
  String get create_One;

  /// No description provided for @oR.
  ///
  /// In en, this message translates to:
  /// **'OR'**
  String get oR;

  /// No description provided for @login_With_Google.
  ///
  /// In en, this message translates to:
  /// **'Login With Google'**
  String get login_With_Google;

  /// No description provided for @please_check_your_email.
  ///
  /// In en, this message translates to:
  /// **'Please check your email'**
  String get please_check_your_email;

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// No description provided for @avatar.
  ///
  /// In en, this message translates to:
  /// **'Avatar'**
  String get avatar;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @confirm_Password.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirm_Password;

  /// No description provided for @password_must_be_at_least_6_characters.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters'**
  String get password_must_be_at_least_6_characters;

  /// No description provided for @password_is_required.
  ///
  /// In en, this message translates to:
  /// **'Password is required'**
  String get password_is_required;

  /// No description provided for @phone_number_required.
  ///
  /// In en, this message translates to:
  /// **'Phone number is required'**
  String get phone_number_required;

  /// No description provided for @name_is_required.
  ///
  /// In en, this message translates to:
  /// **'Name is required'**
  String get name_is_required;

  /// No description provided for @passwords_do_not_match.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwords_do_not_match;

  /// No description provided for @phone_number_invalid.
  ///
  /// In en, this message translates to:
  /// **'Phone number must be at least 11 digits'**
  String get phone_number_invalid;

  /// No description provided for @phone_Number.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phone_Number;

  /// No description provided for @create_Account.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get create_Account;

  /// No description provided for @already_Have_Account.
  ///
  /// In en, this message translates to:
  /// **'Already Have Account'**
  String get already_Have_Account;

  /// No description provided for @verify_Email.
  ///
  /// In en, this message translates to:
  /// **'Verify Email'**
  String get verify_Email;

  /// No description provided for @action.
  ///
  /// In en, this message translates to:
  /// **'Action'**
  String get action;

  /// No description provided for @see_More.
  ///
  /// In en, this message translates to:
  /// **'See More'**
  String get see_More;

  /// No description provided for @doctor_Strange.
  ///
  /// In en, this message translates to:
  /// **'Doctor Strange in the Multiverse of Madness'**
  String get doctor_Strange;

  /// No description provided for @watch.
  ///
  /// In en, this message translates to:
  /// **'Watch'**
  String get watch;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @edit_Profile.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get edit_Profile;

  /// No description provided for @exit.
  ///
  /// In en, this message translates to:
  /// **'Exit'**
  String get exit;

  /// No description provided for @watch_List.
  ///
  /// In en, this message translates to:
  /// **'Watch List'**
  String get watch_List;

  /// No description provided for @history.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get history;

  /// No description provided for @pick_Avatar.
  ///
  /// In en, this message translates to:
  /// **'Pick Avatar'**
  String get pick_Avatar;

  /// No description provided for @reset_Password.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get reset_Password;

  /// No description provided for @delete_Account.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get delete_Account;

  /// No description provided for @update_Data.
  ///
  /// In en, this message translates to:
  /// **'Update Data'**
  String get update_Data;

  /// No description provided for @all_genres.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all_genres;

  /// No description provided for @horror.
  ///
  /// In en, this message translates to:
  /// **'Horror'**
  String get horror;

  /// No description provided for @animation.
  ///
  /// In en, this message translates to:
  /// **'Animation'**
  String get animation;

  /// No description provided for @comedy.
  ///
  /// In en, this message translates to:
  /// **'Comedy'**
  String get comedy;

  /// No description provided for @drama.
  ///
  /// In en, this message translates to:
  /// **'Drama'**
  String get drama;

  /// No description provided for @sci_fi.
  ///
  /// In en, this message translates to:
  /// **'Sci-Fi'**
  String get sci_fi;

  /// No description provided for @fantasy.
  ///
  /// In en, this message translates to:
  /// **'Fantasy'**
  String get fantasy;

  /// No description provided for @romance.
  ///
  /// In en, this message translates to:
  /// **'Romance'**
  String get romance;

  /// No description provided for @crime.
  ///
  /// In en, this message translates to:
  /// **'Crime'**
  String get crime;

  /// No description provided for @adventure.
  ///
  /// In en, this message translates to:
  /// **'Adventure'**
  String get adventure;

  /// No description provided for @biography.
  ///
  /// In en, this message translates to:
  /// **'Biography'**
  String get biography;

  /// No description provided for @documentary.
  ///
  /// In en, this message translates to:
  /// **'Documentary'**
  String get documentary;

  /// No description provided for @family.
  ///
  /// In en, this message translates to:
  /// **'Family'**
  String get family;

  /// No description provided for @history_genre.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get history_genre;

  /// No description provided for @music.
  ///
  /// In en, this message translates to:
  /// **'Music'**
  String get music;

  /// No description provided for @musical.
  ///
  /// In en, this message translates to:
  /// **'Musical'**
  String get musical;

  /// No description provided for @mystery.
  ///
  /// In en, this message translates to:
  /// **'Mystery'**
  String get mystery;

  /// No description provided for @film_noir.
  ///
  /// In en, this message translates to:
  /// **'Film-Noir'**
  String get film_noir;

  /// No description provided for @sport.
  ///
  /// In en, this message translates to:
  /// **'Sport'**
  String get sport;

  /// No description provided for @thriller.
  ///
  /// In en, this message translates to:
  /// **'Thriller'**
  String get thriller;

  /// No description provided for @talk_show.
  ///
  /// In en, this message translates to:
  /// **'Talk-Show'**
  String get talk_show;

  /// No description provided for @war.
  ///
  /// In en, this message translates to:
  /// **'War'**
  String get war;

  /// No description provided for @western.
  ///
  /// In en, this message translates to:
  /// **'Western'**
  String get western;

  /// No description provided for @wish_list.
  ///
  /// In en, this message translates to:
  /// **'wish List'**
  String get wish_list;

  /// No description provided for @favorite_Movie_Here.
  ///
  /// In en, this message translates to:
  /// **'Favorite Movie Here'**
  String get favorite_Movie_Here;

  /// No description provided for @login_successful.
  ///
  /// In en, this message translates to:
  /// **'Login successful!'**
  String get login_successful;

  /// No description provided for @account_created_successfully.
  ///
  /// In en, this message translates to:
  /// **'Account created successfully!'**
  String get account_created_successfully;

  /// No description provided for @user_not_found.
  ///
  /// In en, this message translates to:
  /// **'No account found with this email.'**
  String get user_not_found;

  /// No description provided for @wrong_password.
  ///
  /// In en, this message translates to:
  /// **'Incorrect password. Please try again.'**
  String get wrong_password;

  /// No description provided for @invalid_email.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email address.'**
  String get invalid_email;

  /// No description provided for @user_disabled.
  ///
  /// In en, this message translates to:
  /// **'This account has been disabled.'**
  String get user_disabled;

  /// No description provided for @weak_password.
  ///
  /// In en, this message translates to:
  /// **'Password is too weak. Use at least 6 characters.'**
  String get weak_password;

  /// No description provided for @email_already_in_use.
  ///
  /// In en, this message translates to:
  /// **'An account already exists with this email.'**
  String get email_already_in_use;

  /// No description provided for @invalid_credential.
  ///
  /// In en, this message translates to:
  /// **'Invalid email or password.'**
  String get invalid_credential;

  /// No description provided for @too_many_requests.
  ///
  /// In en, this message translates to:
  /// **'Too many attempts. Please try again later.'**
  String get too_many_requests;

  /// No description provided for @network_request_failed.
  ///
  /// In en, this message translates to:
  /// **'Network error. Please check your internet connection.'**
  String get network_request_failed;

  /// No description provided for @operation_not_allowed.
  ///
  /// In en, this message translates to:
  /// **'This sign-in method is not enabled.'**
  String get operation_not_allowed;

  /// No description provided for @something_went_wrong.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Please try again.'**
  String get something_went_wrong;

  /// No description provided for @valid_user_name.
  ///
  /// In en, this message translates to:
  /// **'Enter valid user name.'**
  String get valid_user_name;

  /// No description provided for @similar.
  ///
  /// In en, this message translates to:
  /// **'Similar'**
  String get similar;

  /// No description provided for @summary.
  ///
  /// In en, this message translates to:
  /// **'Summary'**
  String get summary;

  /// No description provided for @screenshots.
  ///
  /// In en, this message translates to:
  /// **'Screenshots'**
  String get screenshots;

  /// No description provided for @genres.
  ///
  /// In en, this message translates to:
  /// **'Genres'**
  String get genres;

  /// No description provided for @cast.
  ///
  /// In en, this message translates to:
  /// **'Cast'**
  String get cast;

  /// No description provided for @character.
  ///
  /// In en, this message translates to:
  /// **'Character'**
  String get character;

  /// No description provided for @add_to_watch_list.
  ///
  /// In en, this message translates to:
  /// **'Add to watch list'**
  String get add_to_watch_list;

  /// No description provided for @remove_from_watch_list.
  ///
  /// In en, this message translates to:
  /// **'Remove from watch list'**
  String get remove_from_watch_list;

  /// No description provided for @not_available.
  ///
  /// In en, this message translates to:
  /// **'N/A'**
  String get not_available;

  /// No description provided for @enter_email_address.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email address'**
  String get enter_email_address;

  /// No description provided for @password_reset_sent.
  ///
  /// In en, this message translates to:
  /// **'Password reset link sent! Check your email.'**
  String get password_reset_sent;

  /// No description provided for @password_reset_error.
  ///
  /// In en, this message translates to:
  /// **'Unable to send password reset email.'**
  String get password_reset_error;

  /// No description provided for @no_movies_found.
  ///
  /// In en, this message translates to:
  /// **'No movies found'**
  String get no_movies_found;

  /// No description provided for @current_password.
  ///
  /// In en, this message translates to:
  /// **'Current password'**
  String get current_password;

  /// No description provided for @try_again.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get try_again;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
