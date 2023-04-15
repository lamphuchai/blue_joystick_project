import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_text_theme.dart';
import 'theme_components.dart';

class AppThemes {
  static final light = ThemeData(
      primaryColor: AppColors.light.primaryColor,
      colorScheme: AppColors.colorSchemeLight,
      appBarTheme: ThemeComponents.light.appBarTheme,
      iconTheme: ThemeComponents.light.iconThemeData,
      scaffoldBackgroundColor: AppColors.light.backgroundPrimaryColor,
      cardTheme: ThemeComponents.light.cardTheme,
      inputDecorationTheme: ThemeComponents.light.inputDecorationTheme,
      textTheme: AppTextTheme.light,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      listTileTheme: const ListTileThemeData());
  static final dark = ThemeData(
      primaryColor: AppColors.dark.primaryColor,
      colorScheme: AppColors.colorSchemeDark,
      appBarTheme: ThemeComponents.dark.appBarTheme,
      iconTheme: ThemeComponents.dark.iconThemeData,
      scaffoldBackgroundColor: AppColors.dark.backgroundPrimaryColor,
      cardTheme: ThemeComponents.dark.cardTheme,
      inputDecorationTheme: ThemeComponents.dark.inputDecorationTheme,
      textTheme: AppTextTheme.dark,
      splashColor: Colors.transparent,
      // elevatedButtonTheme: ElevatedButtonThemeData(style: ButtonStyle()),
      highlightColor: Colors.transparent);
}
