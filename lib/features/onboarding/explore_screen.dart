import 'package:flutter/material.dart';
import 'package:movies_app/widgets/custom_elevated_button.dart';
import 'package:movies_app/l10n/app_localizations.dart';
import 'package:movies_app/utils/app_assets.dart';
import 'package:movies_app/utils/app_routes.dart';
import 'package:movies_app/utils/app_styles.dart';
import 'package:movies_app/utils/size_utils.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  @override
  Widget build(BuildContext context) {
    var width = context.width;
    var height = context.height;
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            AppAssets.onBoardingImage1,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.fill,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.01),
                child: Text(
                  textAlign: .center,
                  AppLocalizations.of(context)!.find_Your_Next,
                  style: AppStyles.medium36White,
                ),
              ),
              SizedBox(height: height * 0.02),
              Text(
                textAlign: .center,
                AppLocalizations.of(context)!.get_access_to_a_huge,
                style: AppStyles.regular20White,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: height * 0.02,
                  horizontal: width * 0.04,
                ),
                child: CustomElevatedButton(
                  onPressedButton2: () {
                    Navigator.pushReplacementNamed(
                      context,
                      AppRoutes.onboardingScreen,
                    );
                  },
                  title: AppLocalizations.of(context)!.explore_Now,
                  style: AppStyles.semi20Black,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
