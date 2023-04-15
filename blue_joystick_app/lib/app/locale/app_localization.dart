import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'lang/en.dart';
import 'lang/vi.dart';

class AppLocalizations {
  AppLocalizations(this.locale);
  static const defaultLanguage = Locale('vi', 'VN');
  static const supportedLocales = <Locale>[
    Locale('en', 'US'),
    Locale('vi', 'VN'),
  ];
  static Locale localFromString(String text) {
    var code = text.split("-");
    return Locale(code.first, code.last);
  }

  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = [
    _AppLocalizationsDelegate(),
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];
  final Locale locale;
  late Map<String, String> localizedStrings;
  Future<bool> load() async {
    switch (locale.languageCode) {
      case "vi":
        localizedStrings = vi;
        break;
      case "en":
        localizedStrings = en;
        break;
      default:
        break;
    }

    return true;
  }

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  String translate(String key) {
    return localizedStrings[key] ?? key;
  }
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  final String tag = "AppLocalizations";
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'vi'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    AppLocalizations localizations = AppLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
