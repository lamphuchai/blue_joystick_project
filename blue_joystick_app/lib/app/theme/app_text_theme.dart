import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTextTheme {
  static final LightTextTheme _lightTextTheme = LightTextTheme();
  static final DarkTextTheme _darkTextTheme = DarkTextTheme();
  static TextTheme get light => TextTheme(
        displayLarge: _lightTextTheme.displayLarge,
        displayMedium: _lightTextTheme.displayMedium,
        displaySmall: _lightTextTheme.displaySmall,
        headlineLarge: _lightTextTheme.headlineLarge,
        headlineMedium: _lightTextTheme.headlineMedium,
        headlineSmall: _lightTextTheme.headlineSmall,
        titleLarge: _lightTextTheme.titleLarge,
        titleMedium: _lightTextTheme.titleMedium,
        titleSmall: _lightTextTheme.titleSmall,
        bodyLarge: _lightTextTheme.bodyLarge,
        bodyMedium: _lightTextTheme.bodyMedium,
        bodySmall: _lightTextTheme.bodySmall,
        labelLarge: _lightTextTheme.labelLarge,
        labelMedium: _lightTextTheme.labelMedium,
        labelSmall: _lightTextTheme.labelSmall,
      );
  static TextTheme get dark => TextTheme(
        displayLarge: _darkTextTheme.displayLarge,
        displayMedium: _darkTextTheme.displayMedium,
        displaySmall: _darkTextTheme.displaySmall,
        headlineLarge: _darkTextTheme.headlineLarge,
        headlineMedium: _darkTextTheme.headlineMedium,
        headlineSmall: _darkTextTheme.headlineSmall,
        titleLarge: _darkTextTheme.titleLarge,
        titleMedium: _darkTextTheme.titleMedium,
        titleSmall: _darkTextTheme.titleSmall,
        bodyLarge: _darkTextTheme.bodyLarge,
        bodyMedium: _darkTextTheme.bodyMedium,
        bodySmall: _darkTextTheme.bodySmall,
        labelLarge: _darkTextTheme.labelLarge,
        labelMedium: _darkTextTheme.labelMedium,
        labelSmall: _darkTextTheme.labelSmall,
      );
}

class LightTextTheme {
  //
  final displayLarge =
      TextStyle(fontSize: 40, color: AppColors.light.textPrimaryColor);
  final displayMedium =
      TextStyle(fontSize: 34, color: AppColors.light.textPrimaryColor);
  final displaySmall =
      TextStyle(fontSize: 24, color: AppColors.light.textPrimaryColor);
  //
  final headlineLarge = TextStyle(
      fontSize: 30,
      color: AppColors.light.textPrimaryColor,
      fontWeight: FontWeight.bold);
  final headlineMedium = TextStyle(
      fontSize: 20,
      color: AppColors.light.textPrimaryColor,
      fontWeight: FontWeight.bold);
  final headlineSmall = TextStyle(
      fontSize: 16,
      color: AppColors.light.textPrimaryColor,
      fontWeight: FontWeight.bold);

  final titleLarge = TextStyle(
      fontSize: 18,
      color: AppColors.light.textPrimaryColor,
      fontWeight: FontWeight.bold);
  final titleMedium = TextStyle(
      fontSize: 16,
      color: AppColors.light.textPrimaryColor,
      fontWeight: FontWeight.bold);
  final titleSmall = TextStyle(
      fontSize: 14,
      color: AppColors.light.textPrimaryColor,
      fontWeight: FontWeight.bold);
  //
  final bodyLarge =
      TextStyle(fontSize: 16, color: AppColors.light.textPrimaryColor);
  final bodyMedium =
      TextStyle(fontSize: 14, color: AppColors.light.textPrimaryColor);
  final bodySmall =
      TextStyle(fontSize: 12, color: AppColors.light.textPrimaryColor);
  //
  final labelLarge =
      TextStyle(fontSize: 16, color: AppColors.light.textPrimaryColor);
  final labelMedium =
      TextStyle(fontSize: 14, color: AppColors.light.primaryColor);
  final labelSmall =
      TextStyle(fontSize: 12, color: AppColors.light.textPrimaryColor);
  //
  // final caption = TextStyle(fontSize: 12, color: AppColors.light.textSubColor);
  final button = TextStyle(
      fontSize: 16,
      color: AppColors.light.textPrimaryColor,
      fontWeight: FontWeight.bold);
}

class DarkTextTheme {
  //
  final displayLarge =
      TextStyle(fontSize: 40, color: AppColors.dark.textPrimaryColor);
  final displayMedium =
      TextStyle(fontSize: 34, color: AppColors.dark.textPrimaryColor);
  final displaySmall =
      TextStyle(fontSize: 24, color: AppColors.dark.textPrimaryColor);
  //
  final headlineLarge = TextStyle(
      fontSize: 30,
      color: AppColors.dark.textPrimaryColor,
      fontWeight: FontWeight.bold);
  final headlineMedium = TextStyle(
      fontSize: 20,
      color: AppColors.dark.textPrimaryColor,
      fontWeight: FontWeight.bold);
  final headlineSmall = TextStyle(
      fontSize: 16,
      color: AppColors.dark.textPrimaryColor,
      fontWeight: FontWeight.bold);

  final titleLarge = TextStyle(
      fontSize: 18,
      color: AppColors.dark.textPrimaryColor,
      fontWeight: FontWeight.bold);
  final titleMedium = TextStyle(
      fontSize: 16,
      color: AppColors.dark.textPrimaryColor,
      fontWeight: FontWeight.bold);
  final titleSmall = TextStyle(
      fontSize: 14,
      color: AppColors.dark.textPrimaryColor,
      fontWeight: FontWeight.bold);
  //
  final bodyLarge =
      TextStyle(fontSize: 16, color: AppColors.dark.textPrimaryColor);
  final bodyMedium =
      TextStyle(fontSize: 14, color: AppColors.dark.textPrimaryColor);
  final bodySmall =
      TextStyle(fontSize: 12, color: AppColors.dark.textPrimaryColor);
  //
  final labelLarge =
      TextStyle(fontSize: 16, color: AppColors.dark.textPrimaryColor);
  final labelMedium =
      TextStyle(fontSize: 14, color: AppColors.dark.textPrimaryColor);
  final labelSmall =
      TextStyle(fontSize: 12, color: AppColors.dark.textPrimaryColor);
  //
  // final caption = TextStyle(fontSize: 12, color: AppColors.dark.textSubColor);
  final button = TextStyle(
      fontSize: 16,
      color: AppColors.dark.textPrimaryColor,
      fontWeight: FontWeight.bold);
}
