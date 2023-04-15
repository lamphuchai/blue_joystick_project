import 'package:blue_joystick/app/extensions/string_extension.dart';
import 'package:flutter/material.dart';

class AppColors {
  static final LightColors _lightColors = LightColors();
  static final DarkColors _darkColors = DarkColors();

  static LightColors get light => _lightColors;
  static DarkColors get dark => _darkColors;
  static final colorSchemeDark = ColorScheme(
    background: _darkColors.backgroundPrimaryColor,
    onBackground: _darkColors.onBackgroundPrimaryColor,
    //
    surface: _darkColors.surfaceColor,
    onSurface: _darkColors.onSurfaceColor,
    //
    primary: _darkColors.primaryColor,
    onPrimary: _darkColors.onSurfaceColor,
    //
    secondary: _darkColors.primaryColor,
    onSecondary: _darkColors.onSurfaceColor,
    //
    error: Colors.red,
    onError: Colors.red,
    //
    brightness: Brightness.dark,
  );
  static final colorSchemeLight = ColorScheme(
    background: _lightColors.backgroundPrimaryColor,
    onBackground: _lightColors.onBackgroundPrimaryColor,
    //
    surface: _lightColors.surfaceColor,
    onSurface: _lightColors.onSurfaceColor,
    //
    primary: _lightColors.primaryColor,
    onPrimary: _lightColors.onSurfaceColor,
    //
    secondary: _lightColors.primaryColor,
    onSecondary: _lightColors.onSurfaceColor,
    //
    error: Colors.red,
    onError: Colors.red,
    //
    brightness: Brightness.light,
  );
}

class LightColors {
  final primaryColor = "#079992".hexColor;

  final grayColor = "#838383".hexColor;

  final backgroundPrimaryColor = "#f7f6f0".hexColor;
  final onBackgroundPrimaryColor = "#b2bec3".hexColor;

  final onSurfaceColor = "#24282c".hexColor;

  final surfaceColor = "#ffffff".hexColor;

  final textPrimaryColor = "#24282c".hexColor;
  final textSubColor = "#ffffff".hexColor;

  final errorColor = Colors.red;

  final borderSideColor = "#ced6e0".hexColor;
}

class DarkColors {
  final primaryColor = "#079992".hexColor;

  final grayColor = "#83839C".hexColor;

  final backgroundPrimaryColor = "#222831".hexColor;
  final onBackgroundPrimaryColor = "#b2bec3".hexColor;

  final onSurfaceColor = "#eeeeee".hexColor;

  final surfaceColor = "#393e46".hexColor;

  final textPrimaryColor = "#eeeeee".hexColor;
  final textSubColor = "#393e46".hexColor;

  final errorColor = Colors.red;

  final borderSideColor = "#ced6e0".hexColor;
}
