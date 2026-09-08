import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:movies_app/l10n/app_localizations.dart';
import 'package:movies_app/utils/app_assets.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_routes.dart';
import 'package:movies_app/utils/app_styles.dart';
import 'package:movies_app/utils/size_utils.dart';
import 'package:movies_app/widgets/custom_elevated_button.dart';
import 'package:movies_app/widgets/custom_text_field.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController emailController = TextEditingController();
  bool isLoading = false;

  Future<void> resetPassword() async {
    final l10n = AppLocalizations.of(context)!;
    try {
      String email = emailController.text.trim().toLowerCase();
      if (email.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.enter_email_address)),
        );
        return;
      }
      setState(() {
        isLoading = true;
      });
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

      if (!mounted) return;
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.password_reset_sent),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pushReplacementNamed(context, AppRoutes.loginScreen);
    } on FirebaseAuthException catch (e) {
      String message = l10n.something_went_wrong;
      if (e.code == 'user-not-found') {
        message = l10n.user_not_found;
      } else if (e.code == 'invalid-email') {
        message = l10n.invalid_email;
      } else {
        message = e.message ?? l10n.something_went_wrong;
      }

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message), backgroundColor: Colors.red),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${l10n.password_reset_error} $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = context.height;
    var width = context.width;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.blackColor,
      appBar: AppBar(
        backgroundColor: AppColors.blackColor,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, AppRoutes.loginScreen);
          },
          icon: Icon(Icons.arrow_back, color: AppColors.primaryColor),
        ),
        title: Text(l10n.forget_Password, style: AppStyles.regular16Primary),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.035),
            child: Column(
              children: [
                Image.asset(AppAssets.forgetPasswordImage),
                CustomTextField(
                  prefix: SvgPicture.asset(AppAssets.emailIcon),
                  controller: emailController,
                  title: AppLocalizations.of(context)!.email,
                ),

                SizedBox(height: height * 0.02),

                CustomElevatedButton(
                  isLoading: isLoading,
                  onPressedButton2: resetPassword,
                  title: AppLocalizations.of(context)!.verify_Email,
                  style: AppStyles.regular20Black,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
