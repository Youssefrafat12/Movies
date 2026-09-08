import 'package:flutter/material.dart';
import 'package:movies_app/l10n/app_localizations.dart';

class AppValidation {
  static String? validateUserName(BuildContext context, String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppLocalizations.of(context)!.name_is_required;
    }

    if (value.trim().length < 3) {
      return AppLocalizations.of(context)!.valid_user_name;
    }

    if (!RegExp(r'^[a-zA-Z\u0600-\u06FF\s]+$').hasMatch(value.trim())) {
      return AppLocalizations.of(context)!.valid_user_name;
    }

    return null;
  }

  static String? validateEmail(BuildContext context, String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppLocalizations.of(context)!.verify_Email;
    }

    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value.trim())) {
      return AppLocalizations.of(context)!.invalid_email;
    }

    return null;
  }

  static String? validatePassword(BuildContext context, String? value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)!.password_is_required;
    }

    if (value.length < 8) {
      return AppLocalizations.of(context)!.weak_password;
    }

    if (!RegExp(r'(?=.*[A-Z])').hasMatch(value)) {
      return AppLocalizations.of(context)!.weak_password;
    }

    if (!RegExp(r'(?=.*[a-z])').hasMatch(value)) {
      return AppLocalizations.of(context)!.weak_password;
    }

    if (!RegExp(r'(?=.*\d)').hasMatch(value)) {
      return AppLocalizations.of(context)!.weak_password;
    }

    if (!RegExp(r'(?=.*[@$!%*?&])').hasMatch(value)) {
      return AppLocalizations.of(context)!.weak_password;
    }

    return null;
  }

  static String? validateConfirmPassword(
    BuildContext context,
    String? value,
    String password,
  ) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)!.passwords_do_not_match;
    }

    if (value != password) {
      return AppLocalizations.of(context)!.passwords_do_not_match;
    }

    return null;
  }

  static String? validatePhone(BuildContext context, String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppLocalizations.of(context)!.phone_number_required;
    }
    if (value.length < 11) {
      return AppLocalizations.of(context)!.phone_number_invalid;
    }
    return null;
  }
}
