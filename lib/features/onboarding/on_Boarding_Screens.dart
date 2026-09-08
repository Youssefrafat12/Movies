import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:movies_app/features/onboarding/widgets/custom_container.dart';
import 'package:movies_app/l10n/app_localizations.dart';
import 'package:movies_app/utils/app_assets.dart';
import 'package:movies_app/utils/app_routes.dart';

class OnBoardingScreens extends StatefulWidget {
  const OnBoardingScreens({super.key});

  @override
  State<OnBoardingScreens> createState() => _OnBoardingScreensState();
}

class _OnBoardingScreensState extends State<OnBoardingScreens> {
  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController();
    return Scaffold(
      body: PageView(
        controller: pageController,
        children: [
          CustomContainer(
            image: AppAssets.onBoardingImage2,
            text1: AppLocalizations.of(context)!.discover_Movies,
            text2: AppLocalizations.of(context)!.explore_a_vast_collection,
            nameButton1: AppLocalizations.of(context)!.next,
            onPressedButton1: () {
              pageController.nextPage(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
              );
            },
          ),
          CustomContainer(
            image: AppAssets.onBoardingImage3,
            text1: AppLocalizations.of(context)!.explore_All_Genres,
            text2: AppLocalizations.of(
              context,
            )!.discover_movies_from_every_genre,
            nameButton1: AppLocalizations.of(context)!.next,
            onPressedButton1: () {
              pageController.nextPage(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
              );
            },
            nameButton2: AppLocalizations.of(context)!.back,
            onPressedButton2: () {
              pageController.previousPage(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
              );
            },
          ),
          CustomContainer(
            image: AppAssets.onBoardingImage4,
            text1: AppLocalizations.of(context)!.create_Watchlists,
            text2: AppLocalizations.of(context)!.save_movies_to_your_watchlist,
            nameButton1: AppLocalizations.of(context)!.next,
            onPressedButton1: () {
              pageController.nextPage(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
              );
            },
            nameButton2: AppLocalizations.of(context)!.back,
            onPressedButton2: () {
              pageController.previousPage(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
              );
            },
          ),
          CustomContainer(
            image: AppAssets.onBoardingImage5,
            text1: AppLocalizations.of(context)!.rate_Review,
            text2: AppLocalizations.of(context)!.share_your_thoughts,
            nameButton1: AppLocalizations.of(context)!.next,
            onPressedButton1: () {
              pageController.nextPage(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
              );
            },
            nameButton2: AppLocalizations.of(context)!.back,
            onPressedButton2: () {
              pageController.previousPage(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
              );
            },
          ),
          CustomContainer(
            image: AppAssets.onBoardingImage6,
            text1: AppLocalizations.of(context)!.start_Watching_Now,
            nameButton1: AppLocalizations.of(context)!.finish,
            onPressedButton1: () async {
              final preferences = await SharedPreferences.getInstance();
              await preferences.setBool('has_completed_onboarding', true);
              if (!context.mounted) return;
              Navigator.pushReplacementNamed(context, AppRoutes.loginScreen);
            },
            nameButton2: AppLocalizations.of(context)!.back,
            onPressedButton2: () {
              pageController.previousPage(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
              );
            },
          ),
        ],
      ),
    );
  }
}
