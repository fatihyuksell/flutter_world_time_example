import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

enum AppLocale {
  //TODO: Can add for more localizations
  tr(languageCode: 'tr', countryCode: 'TR');

  final String languageCode;
  final String countryCode;

  const AppLocale({
    required this.languageCode,
    required this.countryCode,
  });

  String get readableName {
    switch (this) {
      case AppLocale.tr:
        return 'tr';
    }
  }

  static List<Locale> get supportedLocales {
    return values.map((e) => Locale(e.languageCode, e.countryCode)).toList();
  }

  static List<LocalizationsDelegate> get localizationDelegates => [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ];
}
