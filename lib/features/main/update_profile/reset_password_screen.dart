import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/l10n/app_localizations.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_styles.dart';
import 'package:movies_app/widgets/custom_elevated_button.dart';
import 'package:movies_app/widgets/custom_text_field.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool isSaving = false;
  bool isLoading = false;

  Future<void> _resetPassword() async {
    final currentPassword = currentPasswordController.text;
    final newPassword = newPasswordController.text;
    final confirmPassword = confirmPasswordController.text;
    final user = FirebaseAuth.instance.currentUser;

    if (user?.email == null || currentPassword.isEmpty || newPassword.isEmpty) {
      _showMessage('Please fill in all password fields.');
      return;
    }
    if (newPassword != confirmPassword) {
      _showMessage('New passwords do not match.');
      return;
    }

    setState(() {
      isSaving = true;
      isLoading = true;
    });
    try {
      final credential = EmailAuthProvider.credential(
        email: user!.email!,
        password: currentPassword,
      );
      await user.reauthenticateWithCredential(credential);
      await user.updatePassword(newPassword);
      if (mounted) {
        setState(() {
          isLoading = false;
        });
        _showMessage('Password updated successfully.');
        Navigator.pop(context, true);
      }
    } on FirebaseAuthException catch (error) {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
        _showMessage(error.message ?? 'Unable to update password.');
      }
    } finally {
      if (mounted) setState(() => isSaving = false);
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  void dispose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.darkBlackColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.primaryColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(l.reset_Password, style: AppStyles.bold16Primary),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            CustomTextField(
              title: l.current_password,
              controller: currentPasswordController,
              isObsecure: true,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              title: l.password,
              controller: newPasswordController,
              isObsecure: true,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              title: l.confirm_Password,
              controller: confirmPasswordController,
              isObsecure: true,
            ),
            const Spacer(),
            CustomElevatedButton(
              isLoading: isLoading,
              onPressedButton2: isSaving ? () {} : _resetPassword,
              title: l.update_Data,
              style: AppStyles.regular20Black,
            ),
          ],
        ),
      ),
    );
  }
}
