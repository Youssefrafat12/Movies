import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:movies_app/services/movie_history_service.dart';
import 'package:movies_app/services/profile_service.dart';
import 'package:movies_app/services/locale_controller.dart';
import 'package:movies_app/features/main/tabs/profile/watch/watch_list_service.dart';
import 'package:movies_app/features/auth/login/cubit/auth_view_model.dart';
import 'package:movies_app/services/firebase_service.dart';
import 'features/main/tabs/home/cubit/home_general_cubit.dart';
import 'firebase_options.dart';
import 'package:movies_app/features/auth/forget_password/forget_password_screen.dart';
import 'package:movies_app/features/auth/login/login_screen.dart';
import 'package:movies_app/features/auth/register/regsister_screen.dart';
import 'package:movies_app/features/main/movie_details/cubit/movie_details_view_model.dart';
import 'package:movies_app/features/main/movie_details/movie_suggestions/cubit/movie_suggestion_view_model.dart';
import 'package:movies_app/features/main/movie_details/widgets/movie_details_bloc_builder.dart';
import 'package:movies_app/l10n/app_localizations.dart';
import 'package:movies_app/features/main/tabs/browse/browse_tab.dart';
import 'package:movies_app/features/main/tabs/profile/profile_tab.dart';
import 'package:movies_app/features/main/main_screen.dart';
import 'package:movies_app/features/onboarding/explore_screen.dart';
import 'package:movies_app/features/main/update_profile/update_profile_screen.dart';
import 'package:movies_app/features/main/update_profile/reset_password_screen.dart';
import 'package:movies_app/features/onboarding/on_boarding_screens.dart';
import 'package:movies_app/utils/app_routes.dart';
import 'package:movies_app/utils/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await MovieHistoryService.instance.initialize();
  await WatchListService.instance.initialize();
  await ProfileService.instance.initialize();
  final preferences = await SharedPreferences.getInstance();
  final languageCode = preferences.getString('language_code') ?? 'en';
  final hasCompletedOnboarding =
      preferences.getBool('has_completed_onboarding') ?? false;
  if (!hasCompletedOnboarding) {
    await preferences.setBool('has_completed_onboarding', true);
  }
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<LocaleCubit>(
          create: (_) => LocaleCubit(
            initialLocale: Locale(languageCode),
          ),
        ),
        BlocProvider<MovieSuggestionViewModel>(
          create: (context) => MovieSuggestionViewModel(),
        ),
        BlocProvider<AuthViewModel>(
          create: (context) => AuthViewModel(AuthService()),
        ),
        BlocProvider<HomeGeneralCubit>(
          create: (context) => HomeGeneralCubit(),
        ),
      ],
      child: MoviesApp(hasCompletedOnboarding: hasCompletedOnboarding),
    ),
  );
}

class MoviesApp extends StatelessWidget {
  final bool hasCompletedOnboarding;

  const MoviesApp({super.key, required this.hasCompletedOnboarding});

  @override
  Widget build(BuildContext context) {
    final locale = context.watch<LocaleCubit>().state;

    return MaterialApp(
      locale: locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      debugShowCheckedModeBanner: false,
      routes: {
        AppRoutes.updateProfileScreen: (context) => UpdateProfileScreen(),
        AppRoutes.resetPasswordScreen: (context) => const ResetPasswordScreen(),
        AppRoutes.mainScreen: (context) {
          final arguments = ModalRoute.of(context)?.settings.arguments;
          if (arguments is Map<String, dynamic>) {
            return MainScreen(
              initialIndex: arguments['initialIndex'] as int? ?? 0,
              browseGenre: arguments['browseGenre'] as String?,
            );
          }
          return const MainScreen();
        },
        AppRoutes.exploreScreen: (context) => const ExploreScreen(),
        AppRoutes.loginScreen: (context) => const LoginScreen(),
        AppRoutes.registerScreen: (context) => const RegisterScreen(),
        AppRoutes.forgotPasswordScreen: (context) =>
            const ForgetPasswordScreen(),
        AppRoutes.onboardingScreen: (context) => OnBoardingScreens(),
        AppRoutes.movieDetailsScreen: (context) => BlocProvider(
          create: (context) => MovieDetailsViewModel(),
          child: MovieDetailsBlocBuilder(),
        ),
        AppRoutes.browseScreen: (context) => BrowseTab(),
        AppRoutes.profileScreen: (context) => ProfileTab(),
      },
      initialRoute: FirebaseAuth.instance.currentUser != null
          ? AppRoutes.mainScreen
          : hasCompletedOnboarding
          ? AppRoutes.loginScreen
          : AppRoutes.exploreScreen,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,
    );
  }
}
