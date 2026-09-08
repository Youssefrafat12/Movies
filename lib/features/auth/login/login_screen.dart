import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies_app/features/auth/login/widgets/google_sign_in_button.dart';
import 'package:movies_app/features/auth/login/widgets/language_switcher.dart';
import 'package:movies_app/services/locale_controller.dart';
import 'package:movies_app/services/firebase_service.dart';
import 'package:movies_app/utils/app_validation.dart';
import 'package:movies_app/widgets/app_overlay.dart';
import 'package:movies_app/widgets/custom_elevated_button.dart';
import 'package:movies_app/l10n/app_localizations.dart';
import 'package:movies_app/utils/app_assets.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_routes.dart';
import 'package:movies_app/utils/app_styles.dart';
import 'package:movies_app/utils/size_utils.dart';
import 'package:movies_app/widgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController(
    text: "youssef@example.com",
  );
  final TextEditingController passwordController = TextEditingController(
    text: "Youssef123@",
  );

  bool isPasswordVisible = false;
  var formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    var height = context.height;
    var width = context.width;

    return Scaffold(
      backgroundColor: AppColors.blackColor,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.024),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      SizedBox(height: height * 0.024),
                      Image.asset(AppAssets.mainLogo),
                      SizedBox(height: height * 0.069),
                      CustomTextField(
                        type: TextInputType.emailAddress,
                        title: l10n.email,
                        prefix: SvgPicture.asset(AppAssets.emailIcon),
                        controller: emailController,
                        validation: (text) {
                          return AppValidation.validateEmail(context, text);
                        },
                      ),
                      SizedBox(height: height * 0.022),
                      CustomTextField(
                        type: TextInputType.visiblePassword,
                        title: l10n.password,
                        prefix: SvgPicture.asset(AppAssets.passwordIcon),
                        suffix: IconButton(
                          onPressed: () {
                            setState(() {
                              isPasswordVisible = !isPasswordVisible;
                            });
                          },
                          icon: Icon(
                            isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        ),
                        controller: passwordController,
                        validation: (text) {
                          return AppValidation.validatePassword(context, text);
                        },
                        isObsecure: !isPasswordVisible,
                      ),
                      SizedBox(height: height * 0.017),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: EdgeInsets.only(top: height * 0.0017),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushReplacementNamed(
                                context,
                                AppRoutes.forgotPasswordScreen,
                              );
                            },
                            child: Text(
                              '${l10n.forget_Password} ?',
                              style: AppStyles.regular14Primary,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.033),
                      CustomElevatedButton(
                        isLoading: isLoading,
                        onPressedButton2: () {
                          login(context);
                        },
                        title: l10n.login,
                        style: AppStyles.regular20Black,
                      ),
                      SizedBox(height: height * 0.022),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${l10n.dont_Have_Account} ? ',
                            style: AppStyles.regular14White,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacementNamed(
                                context,
                                AppRoutes.registerScreen,
                              );
                            },
                            child: Text(
                              l10n.create_One,
                              style: AppStyles.bold14Primary.copyWith(
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: height * 0.027),
                      Row(
                        children: [
                          const Expanded(
                            child: Divider(
                              color: AppColors.primaryColor,
                              indent: 100,
                              endIndent: 10,
                            ),
                          ),
                          Text(l10n.oR, style: AppStyles.regular16Primary),
                          const Expanded(
                            child: Divider(
                              color: AppColors.primaryColor,
                              indent: 10,
                              endIndent: 100,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: height * 0.027),
                      GoogleSignInButton(),
                      SizedBox(height: height * 0.033),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: .circular(30),
                          border: .all(color: AppColors.primaryColor, width: 3),
                        ),
                        child: Row(
                          mainAxisSize: .min,
                          spacing: width * 0.03,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            LanguageSwitcher(
                              icon: AppAssets.enIcon,
                              isSelected: context
                                  .watch<LocaleCubit>()
                                  .state
                                  .languageCode == 'en',
                              onTap: () {
                                context.read<LocaleCubit>().setLanguage(
                                  'en',
                                );
                              },
                            ),
                            LanguageSwitcher(
                              icon: AppAssets.arIcon,
                              isSelected: context
                                  .watch<LocaleCubit>()
                                  .state
                                  .languageCode == 'ar',
                              onTap: () {
                                context.read<LocaleCubit>().setLanguage(
                                  'ar',
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  final authService = AuthService();
  bool isLoading = false;

  void login(BuildContext context) async {
    final l10n = AppLocalizations.of(context)!;

    if (formKey.currentState?.validate() != true) return;

    setState(() => isLoading = true);

    final result = await authService.login(
      email: emailController.text,
      password: passwordController.text,
    );

    if (!mounted || !context.mounted) return;
    setState(() => isLoading = false);

    if (result.success) {
      AppOverlay.showSuccess(
        context,
        l10n.login_successful,
        onFinished: () {
          if (context.mounted) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes.mainScreen,
              (route) => false,
            );
          }
        },
      );
    } else {
      AppOverlay.showError(
        context,
        getAuthErrorMessage(l10n, result.errorCode!),
      );
    }
  }
}
