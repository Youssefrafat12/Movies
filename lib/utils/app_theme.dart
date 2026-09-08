import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_styles.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.lightBackgroundColor,
    colorScheme: const ColorScheme.light(
      primary: AppColors.primaryColor,
      onPrimary: AppColors.blackColor,
      surface: AppColors.whiteColor,
      onSurface: AppColors.lightTextColor,
      error: AppColors.redColor,
    ),

    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.lightBackgroundColor,
      foregroundColor: AppColors.lightTextColor,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: AppStyles.bold20Black,
    ),

    textTheme: TextTheme(
      headlineLarge: AppStyles.bold24Black,
      headlineMedium: AppStyles.bold20Black,
      titleLarge: AppStyles.bold18Black,
      titleMedium: AppStyles.bold16Black,
      bodyLarge: AppStyles.regular14Black,
      bodyMedium: AppStyles.regular13Black,
      bodySmall: AppStyles.regular12Grey,
      labelLarge: AppStyles.bold14Black,
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.lightGreyColor,

      hintStyle: AppStyles.regular12Grey,
      labelStyle: AppStyles.regular13Grey,

      prefixIconColor: AppColors.lightSecondaryTextColor,
      suffixIconColor: AppColors.lightSecondaryTextColor,

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide.none,
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide.none,
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: AppColors.primaryColor, width: 1.5),
      ),

      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: AppColors.redColor),
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: AppColors.blackColor,
        elevation: 0,
        minimumSize: const Size(double.infinity, 48),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        textStyle: AppStyles.bold14Black,
      ),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.blackColor,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.primaryColor,
      onPrimary: AppColors.blackColor,
      surface: AppColors.blackColor,
      onSurface: AppColors.whiteColor,
      error: AppColors.redColor,
    ),

    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.blackColor,
      foregroundColor: AppColors.whiteColor,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: AppStyles.bold20White,
    ),

    textTheme: TextTheme(
      headlineLarge: AppStyles.bold24White,
      headlineMedium: AppStyles.bold20White,
      titleLarge: AppStyles.bold18White,
      titleMedium: AppStyles.bold16White,
      bodyLarge: AppStyles.regular14White,
      bodyMedium: AppStyles.regular13White,
      bodySmall: AppStyles.regular12Grey,
      labelLarge: AppStyles.bold14Black,
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.darkGreyColor,

      hintStyle: AppStyles.regular16White,
      labelStyle: AppStyles.regular16White,

      prefixIconColor: AppColors.whiteColor,
      suffixIconColor: AppColors.whiteColor,

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide.none,
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide.none,
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: AppColors.primaryColor),
      ),

      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: AppColors.redColor),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: AppColors.redColor),
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: AppColors.blackColor,
        elevation: 0,
        minimumSize: const Size(double.infinity, 48),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        textStyle: AppStyles.bold14Black,
      ),
    ),
  );
}
