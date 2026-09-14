import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_fonts.dart';

class AppThemeData {
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.white,
    cardColor: AppColors.white,
    fontFamily: AppFonts.pretendard,
    primaryColor: AppColors.primary,
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.primary,
      onPrimary: AppColors.white,
      secondary: AppColors.secondary,
      onSecondary: AppColors.black,
      error: AppColors.error,
      onError: AppColors.white,
      surface: AppColors.white,
      onSurface: AppColors.black,
    ),
    textTheme: _lightTextTheme(ThemeData.light().textTheme),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(
          color: AppColors.borderColor,
          width: 2,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(
          color: AppColors.borderColor,
          width: 2,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(
          color: AppColors.primary,
          width: 2,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(
          color: AppColors.error,
          width: 1.5,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(
          color: AppColors.error,
          width: 2,
        ),
      ),
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
      floatingLabelBehavior: FloatingLabelBehavior.never,
      hintStyle: const TextStyle(
        color: AppColors.disabled,
        fontSize: 15.0,
      ),
    ),
  );
}

TextTheme _lightTextTheme(TextTheme textTheme) {
  return textTheme.copyWith(
    bodySmall: textTheme.bodySmall?.copyWith(
      fontFamily: AppFonts.pretendard,
      fontSize: 13,
      color: AppColors.black,
      fontWeight: FontWeight.w500,
    ),
    bodyMedium: textTheme.bodyMedium?.copyWith(
      fontFamily: AppFonts.plusJakartaSans,
      fontSize: 14,
      color: AppColors.black,
      fontWeight: FontWeight.w500,
    ),
    bodyLarge: textTheme.bodyLarge?.copyWith(
      fontFamily: AppFonts.pretendard,
      fontSize: 20,
      color: AppColors.black,
      fontWeight: FontWeight.w500,
    ),
    titleLarge: textTheme.titleLarge?.copyWith(
      fontFamily: AppFonts.pretendard,
      fontSize: 28,
      color: AppColors.black,
      fontWeight: FontWeight.w400,
    ),
    titleMedium: textTheme.titleMedium?.copyWith(
      fontFamily: AppFonts.pretendard,
      fontSize: 20,
      color: AppColors.black,
      fontWeight: FontWeight.w600,
    ),
    titleSmall: textTheme.titleSmall?.copyWith(
      fontFamily: AppFonts.pretendard,
      fontSize: 16,
      color: AppColors.black,
      fontWeight: FontWeight.w400,
    ),
    labelMedium: textTheme.labelMedium?.copyWith(
      fontFamily: AppFonts.plusJakartaSans,
      fontSize: 14,
      color: AppColors.black,
      fontWeight: FontWeight.w600,
    ),
    labelLarge: textTheme.labelLarge?.copyWith(
      fontFamily: AppFonts.pretendard,
      fontSize: 16,
      color: AppColors.black,
      fontWeight: FontWeight.w600,
    ),
    headlineSmall: textTheme.headlineSmall?.copyWith(
      fontFamily: AppFonts.pretendard,
      fontSize: 30,
      color: AppColors.black,
      fontWeight: FontWeight.w800,
    ),
  );
}
