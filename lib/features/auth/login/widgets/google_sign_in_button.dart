import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movies_app/features/auth/login/cubit/auth_state.dart';
import 'package:movies_app/features/auth/login/cubit/auth_view_model.dart';
import 'package:movies_app/l10n/app_localizations.dart';
import 'package:movies_app/utils/app_assets.dart';
import 'package:movies_app/utils/app_routes.dart';
import 'package:movies_app/utils/app_styles.dart';
import 'package:movies_app/utils/size_utils.dart';
import 'package:movies_app/widgets/custom_elevated_button.dart';

class GoogleSignInButton extends StatelessWidget {
  const GoogleSignInButton({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final height = context.height;

    return BlocConsumer<AuthViewModel, AuthState>(
      listener: (context, state) {
        if (state is GoogleSignInSuccess) {
          Navigator.pushNamed(context, AppRoutes.mainScreen);
        }

        if (state is GoogleSignInFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        final isLoading = state is GoogleSignInLoading;

        return CustomElevatedButton(
          isLoading: isLoading,
          onPressedButton2: () {
            if (isLoading) return;

            context.read<AuthViewModel>().signInWithGoogle();
          },
          title: l10n.login_With_Google,
          style: AppStyles.regular20Black,
          child: SvgPicture.asset(AppAssets.googleIcon, height: height * 0.026),
        );
      },
    );
  }
}
