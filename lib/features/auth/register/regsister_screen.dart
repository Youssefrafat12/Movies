import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movies_app/features/auth/register/widgets/customized_avatar.dart';
import 'package:movies_app/services/profile_service.dart';
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
import 'package:movies_app/features/auth/login/widgets/language_switcher.dart';
import 'package:movies_app/services/locale_controller.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController nameController = TextEditingController(
    text: "Ahmed",
  );
  final TextEditingController emailController = TextEditingController(
    text: "renad99@example.com",
  );
  final TextEditingController passwordController = TextEditingController(
    text: "@#Aahmed123",
  );
  final TextEditingController confirmPasswordController = TextEditingController(
    text: "@#Aahmed123",
  );
  final TextEditingController phoneController = TextEditingController(
    text: "01000080975",
  );
  var formKey = GlobalKey<FormState>();
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;
  final List<String> avatarImages = [
    AppAssets.profileImage1,
    AppAssets.profileImage2,
    AppAssets.profileImage3,
    AppAssets.profileImage4,
    AppAssets.profileImage5,
    AppAssets.profileImage6,
    AppAssets.profileImage7,
    AppAssets.profileImage8,
    AppAssets.profileImage9,
  ];

  int selectedAvatarIndex = 7;
  late final PageController _avatarPageController;

  @override
  void initState() {
    super.initState();
    _avatarPageController = PageController(
      initialPage: selectedAvatarIndex,
      viewportFraction: 0.3,
    );
  }

  @override
  void dispose() {
    _avatarPageController.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = context.height;
    var width = context.width;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.blackColor,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, AppRoutes.loginScreen);
          },
          icon: const Icon(Icons.arrow_back, color: AppColors.primaryColor),
        ),
        title: Text(l10n.register, style: AppStyles.regular16Primary),
      ),

      backgroundColor: AppColors.blackColor,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.024),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: height * 0.112,
                    child: PageView.builder(
                      controller: _avatarPageController,
                      itemCount: avatarImages.length,
                      onPageChanged: (index) {
                        setState(() => selectedAvatarIndex = index);
                      },
                      itemBuilder: (context, index) {
                        final bool isSelected = index == selectedAvatarIndex;
                        return Center(
                          child: CustomizedAvatar(
                            imagePath: avatarImages[index],
                            size: isSelected ? 100 : 72,
                            isSelected: isSelected,
                            onTap: () {
                              _avatarPageController.animateToPage(
                                index,
                                duration: const Duration(milliseconds: 250),
                                curve: Curves.easeOut,
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: height * 0.010),
                  Text(l10n.avatar, style: AppStyles.regular16White),
                  SizedBox(height: height * 0.010),
                  CustomTextField(
                    title: l10n.name,
                    prefix: SvgPicture.asset(AppAssets.nameIcon),
                    controller: nameController,
                    validation: (text) {
                      return AppValidation.validateUserName(context, text);
                    },
                  ),
                  SizedBox(height: height * 0.024),

                  CustomTextField(
                    type: TextInputType.emailAddress,
                    title: l10n.email,
                    prefix: SvgPicture.asset(AppAssets.emailIcon),
                    controller: emailController,
                    validation: (text) {
                      return AppValidation.validateEmail(context, text);
                    },
                  ),

                  SizedBox(height: height * 0.024),
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
                  SizedBox(height: height * 0.024),

                  CustomTextField(
                    type: TextInputType.visiblePassword,
                    title: l10n.confirm_Password,
                    prefix: SvgPicture.asset(AppAssets.passwordIcon),
                    suffix: IconButton(
                      onPressed: () {
                        setState(() {
                          isConfirmPasswordVisible = !isConfirmPasswordVisible;
                        });
                      },
                      icon: Icon(
                        isConfirmPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                    ),
                    controller: confirmPasswordController,
                    validation: (text) {
                      return AppValidation.validateConfirmPassword(
                        context,
                        text,
                        passwordController.text,
                      );
                    },
                    isObsecure: !isConfirmPasswordVisible,
                  ),

                  SizedBox(height: height * 0.024),
                  CustomTextField(
                    type: TextInputType.phone,
                    title: l10n.phone_Number,
                    prefix: SvgPicture.asset(AppAssets.phoneIcon),
                    controller: phoneController,
                    validation: (text) {
                      return AppValidation.validatePhone(context, text);
                    },
                  ),
                  SizedBox(height: height * 0.024),
                  CustomElevatedButton(
                    isLoading: isLoading,
                    onPressedButton2: () {
                      register(context);
                    },
                    title: l10n.create_Account,
                    style: AppStyles.regular20Black,
                  ),
                  SizedBox(height: height * 0.017),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${l10n.already_Have_Account} ? ',
                        style: AppStyles.regular14White,
                      ),

                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacementNamed(
                            context,
                            AppRoutes.loginScreen,
                          );
                        },
                        child: Text(
                          l10n.login,
                          style: AppStyles.bold14Primary.copyWith(
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: height * 0.018),
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
                            context.read<LocaleCubit>().setLanguage('en');
                          },
                        ),
                        LanguageSwitcher(
                          icon: AppAssets.arIcon,
                          isSelected: context
                              .watch<LocaleCubit>()
                              .state
                              .languageCode == 'ar',
                          onTap: () {
                            context.read<LocaleCubit>().setLanguage('ar');
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  final authService = AuthService();
  bool isLoading = false;

  void register(BuildContext context) async {
    final l10n = AppLocalizations.of(context)!;

    if (formKey.currentState?.validate() != true) return;

    if (passwordController.text != confirmPasswordController.text) {
      AppOverlay.showError(context, l10n.passwords_do_not_match);
      return;
    }

    setState(() => isLoading = true);

    final result = await authService.register(
      email: emailController.text,
      password: passwordController.text,
    );

    if (!mounted) return;
    setState(() => isLoading = false);

    if (result.success) {
      await ProfileService.instance.updateProfile(
        name: nameController.text.trim(),
        phone: phoneController.text.trim(),
        avatar: avatarImages[selectedAvatarIndex],
      );
      if (!context.mounted) return;
      final navigator = Navigator.of(context);
      AppOverlay.showSuccess(
        context,
        l10n.account_created_successfully,
        onFinished: () {
          if (navigator.mounted) {
            navigator.pushNamedAndRemoveUntil(
              AppRoutes.loginScreen,
              (route) => false,
            );
          }
        },
      );
    } else {
      if (!context.mounted) return;
      AppOverlay.showError(
        context,
        getAuthErrorMessage(l10n, result.errorCode!),
      );
    }
  }
}
