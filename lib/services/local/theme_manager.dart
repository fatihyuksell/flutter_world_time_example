import 'package:flutter/material.dart';
import 'package:optimus_case/enums/shared_constants.dart';
import 'package:optimus_case/services/local/shared_preferences_manager.dart';
import 'package:optimus_case/utils/app_colors.dart';
import 'package:optimus_case/utils/text_style.dart';

class ThemeManager extends ChangeNotifier {
  final SharedPreferenceManager _sharedPrefManager;

  ThemeManager(this._sharedPrefManager);

  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  Future<void> initialize() async {
    final themeIndex =
        _sharedPrefManager.get<int>(SharedConstants.themeMode.value) ??
            ThemeMode.system.index;
    _themeMode = ThemeMode.values[themeIndex];
    notifyListeners();
  }

  Future<void> toggleTheme(ThemeMode mode) async {
    _themeMode = mode;
    await _sharedPrefManager.set(SharedConstants.themeMode.value, mode.index);
    notifyListeners();
  }

  ThemeData get currentTheme =>
      _themeMode == ThemeMode.dark ? darkTheme : lightTheme;

  ThemeData get lightTheme => ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Montserrat',
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.black),
          bodyMedium: TextStyle(color: Colors.black),
        ),
        useMaterial3: true,
        extensions: <ThemeExtension<dynamic>>[
          TextStyles.light(),
          AppColors.light(),
        ],
      );

  ThemeData get darkTheme => ThemeData(
        brightness: Brightness.dark,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Montserrat',
        primarySwatch: Colors.deepPurple,
        scaffoldBackgroundColor: Colors.black,
        useMaterial3: true,
        extensions: <ThemeExtension<dynamic>>[
          TextStyles.dark(),
          AppColors.dark(),
        ],
      );

  bool get isDarkMode => _themeMode == ThemeMode.dark;

  bool get isLightMode => _themeMode == ThemeMode.light;
}
