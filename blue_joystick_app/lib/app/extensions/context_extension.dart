import 'package:flutter/material.dart';

import '../locale/app_localization.dart';

extension AppContext on BuildContext {
  TextTheme get appTextTheme => Theme.of(this).textTheme;
  ThemeData get appTheme => Theme.of(this);
  ColorScheme get colors => Theme.of(this).colorScheme;
  String translate(String key) => AppLocalizations.of(this).translate(key);
  double get height => MediaQuery.of(this).size.height;
  double get width => MediaQuery.of(this).size.width;
}
