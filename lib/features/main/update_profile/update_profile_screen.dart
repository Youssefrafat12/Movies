import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies_app/services/profile_service.dart';
import 'package:movies_app/widgets/custom_elevated_button.dart';
import 'package:movies_app/l10n/app_localizations.dart';
import 'package:movies_app/features/main/update_profile/widgets/update_profile_avatar.dart';
import 'package:movies_app/features/auth/login/widgets/language_switcher.dart';
import 'package:movies_app/services/locale_controller.dart';
import 'package:movies_app/utils/app_assets.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_routes.dart';
import 'package:movies_app/utils/app_styles.dart';
import 'package:movies_app/widgets/custom_text_field.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  String selectedAvatar = AppAssets.profileImage8;
  String nameHint = '';
  String phoneHint = '';
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  bool isLoading = true;
  bool isDeleteLoading = false;
  bool isUpadateLoading = false;
  bool isSaving = false;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      if (mounted) setState(() => isLoading = false);
      return;
    }

    final profile = await ProfileService.instance.loadProfile();
    nameHint = (profile['name'] as String?) ?? user.displayName ?? '';
    phoneHint = (profile['phone'] ?? profile['phoneNumber'] ?? user.phoneNumber)
        ?.toString() ??
      '';
    nameController.clear();
    phoneController.clear();
    selectedAvatar = (profile['avatar'] as String?) ?? AppAssets.profileImage8;
    if (mounted) setState(() => isLoading = false);
  }

  Future<void> _updateProfile() async {
    setState(() {
      isSaving = true;
      isUpadateLoading = true;
    });
    try {
      await ProfileService.instance.updateProfile(
        name: nameController.text.trim().isEmpty
            ? nameHint
            : nameController.text.trim(),
        phone: phoneController.text.trim().isEmpty
            ? phoneHint
            : phoneController.text.trim(),
        avatar: selectedAvatar,
      );
      if (mounted) {
        setState(() {
          isUpadateLoading = false;
        });
        Navigator.pop(context, true);
      }
    } on FirebaseException catch (error) {
      if (mounted) {
        setState(() {
          isUpadateLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error.message ?? 'Unable to update profile')),
        );
      }
    } finally {
      if (mounted) setState(() => isSaving = false);
    }
  }

  Future<void> _deleteAccount() async {
    try {
      setState(() {
        isDeleteLoading = true;
      });
      await ProfileService.instance.deleteAccount();
      if (mounted) {
        setState(() {
          isDeleteLoading = false;
        });
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.loginScreen,
          (route) => false,
        );
      }
    } on FirebaseException catch (error) {
      if (mounted) {
        setState(() {
          isDeleteLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error.message ?? 'Unable to delete account')),
        );
      }
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  void _showAvatarBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.darkBlackColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: UpdateProfileAvatar(
              selectedAvatar: selectedAvatar,
              onAvatarSelected: (newAvatar) {
                setState(() {
                  selectedAvatar = newAvatar;
                });
                Navigator.pop(context);
              },
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var l = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.darkBlackColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          padding: EdgeInsets.zero,
          icon: Icon(Icons.arrow_back, color: AppColors.primaryColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(l.pick_Avatar, style: AppStyles.bold16Primary),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.04,
          vertical: height * 0.02,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: GestureDetector(
                onTap: _showAvatarBottomSheet,
                child: Image.asset(
                  selectedAvatar,
                  height: height * 0.13,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: height * 0.02),

            CustomTextField(
              title: l.name,
              hintText: nameHint.isEmpty ? null : nameHint,
              prefix: SvgPicture.asset(AppAssets.profileNameIcon),
              controller: nameController,
            ),

            SizedBox(height: height * 0.02),

            CustomTextField(
              title: l.phone_Number,
              hintText: phoneHint.isEmpty ? null : phoneHint,
              prefix: SvgPicture.asset(AppAssets.phoneIcon),
              controller: phoneController,
            ),

            SizedBox(height: height * 0.01),
            TextButton(
              onPressed: () =>
                  Navigator.pushNamed(context, AppRoutes.resetPasswordScreen),
              child: Text(l.reset_Password, style: AppStyles.bold16White),
            ),
            Align(
              alignment: AlignmentDirectional.center,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: AppColors.primaryColor, width: 3),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  spacing: width * 0.03,
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
            ),
            Spacer(),
            CustomElevatedButton(
              isLoading: isDeleteLoading,
              bgColor: AppColors.redColor,
              onPressedButton2: _deleteAccount,
              title: l.delete_Account,
              style: AppStyles.regular20White,
            ),

            SizedBox(height: height * 0.019),
            CustomElevatedButton(
              isLoading: isUpadateLoading,
              onPressedButton2: isLoading || isSaving ? () {} : _updateProfile,
              title: l.update_Data,
              style: AppStyles.regular20Black,
            ),
            SizedBox(height: height * 0.01),
          ],
        ),
      ),
    );
  }
}
