import 'package:flutter/material.dart';

class AppColors extends ThemeExtension<AppColors> {
  final Color appBarBg;
  final Color primary;
  final Color secondary;
  final Color background;
  final Color text;

  const AppColors({
    required this.appBarBg,
    required this.primary,
    required this.secondary,
    required this.background,
    required this.text,
  });

  @override
  ThemeExtension<AppColors> lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) return this;

    return AppColors(
      appBarBg: Color.lerp(appBarBg, other.appBarBg, t)!,
      primary: Color.lerp(primary, other.primary, t)!,
      secondary: Color.lerp(secondary, other.secondary, t)!,
      background: Color.lerp(background, other.background, t)!,
      text: Color.lerp(text, other.text, t)!,
    );
  }

  @override
  AppColors copyWith({
    Color? appBarBg,
    Color? primary,
    Color? secondary,
    Color? background,
    Color? text,
  }) {
    return AppColors(
      appBarBg: appBarBg ?? this.appBarBg,
      primary: primary ?? this.primary,
      secondary: secondary ?? this.secondary,
      background: background ?? this.background,
      text: text ?? this.text,
    );
  }

  factory AppColors.light() => const AppColors(
        appBarBg: Color(0xFFD4DEF1),
        primary: Colors.white,
        secondary: Colors.lightBlueAccent,
        background: Colors.white,
        text: Colors.black,
      );

  factory AppColors.dark() => const AppColors(
        appBarBg: Color(0xFF293A89),
        primary: Colors.deepPurple,
        secondary: Colors.purpleAccent,
        background: Colors.black,
        text: Colors.white,
      );
}
