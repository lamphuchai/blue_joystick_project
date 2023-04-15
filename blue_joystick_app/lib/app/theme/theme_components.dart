import 'package:flutter/material.dart';

import '../constants.dart';
import 'app_colors.dart';
import 'app_text_theme.dart';

class ThemeComponents {
  static final LightComponents _lightComponents = LightComponents();
  static final DarkComponents _darkComponents = DarkComponents();

  static LightComponents get light => _lightComponents;
  static DarkComponents get dark => _darkComponents;
}

class LightComponents {
  final appBarTheme = AppBarTheme(
      centerTitle: true,
      elevation: 0,
      backgroundColor: AppColors.light.backgroundPrimaryColor,
      foregroundColor: AppColors.light.onSurfaceColor,
      titleTextStyle: AppTextTheme.light.titleLarge);
  final iconThemeData = IconThemeData(color: AppColors.light.onSurfaceColor);
  final cardTheme = CardTheme(
      margin: const EdgeInsets.all(0),
      color: AppColors.colorSchemeLight.surface,
      shape: Constants.shape);
  final inputDecorationTheme = InputDecorationTheme(
    border: _border,
    enabledBorder: _border,
    focusedBorder: _focusedBorder,
    errorBorder: _errorBorder,
    hintStyle: AppTextTheme.light.labelMedium
        ?.copyWith(color: AppColors.light.grayColor),
    filled: true,
    fillColor: AppColors.light.surfaceColor,
    focusedErrorBorder: _errorBorder,
  );

  static final _border = OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.light.surfaceColor),
      borderRadius: Constants.borderRadius);

  static final _errorBorder = OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.light.errorColor),
      borderRadius: Constants.borderRadius);

  static final _focusedBorder = OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.light.borderSideColor),
      borderRadius: Constants.borderRadius);
}

class DarkComponents {
  final appBarTheme = AppBarTheme(
      elevation: 0,
      centerTitle: true,
      backgroundColor: AppColors.dark.backgroundPrimaryColor,
      foregroundColor: AppColors.dark.onSurfaceColor,
      titleTextStyle: AppTextTheme.dark.titleLarge);
  final iconThemeData = IconThemeData(color: AppColors.dark.onSurfaceColor);
  final cardTheme = CardTheme(
      margin: const EdgeInsets.all(0),
      color: AppColors.colorSchemeDark.surface,
      shape: Constants.shape);
  final inputDecorationTheme = InputDecorationTheme(
    border: _border,
    enabledBorder: _border,
    focusedBorder: _focusedBorder,
    errorBorder: _errorBorder,
    hintStyle: AppTextTheme.dark.labelMedium
        ?.copyWith(color: AppColors.dark.grayColor),
    filled: true,
    fillColor: AppColors.dark.surfaceColor,
    focusedErrorBorder: _errorBorder,
  );
  static final _border = OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.dark.surfaceColor),
      borderRadius: Constants.borderRadius);

  static final _errorBorder = OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.dark.errorColor),
      borderRadius: Constants.borderRadius);

  static final _focusedBorder = OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.dark.borderSideColor),
      borderRadius: Constants.borderRadius);
}
