import 'package:flutter/material.dart';

class AppColors extends ThemeExtension<AppColors> {
  final Color appBarBg;
  final Color primary;
  final Color secondary;
  final Color background;
  final Color green;
  final Color red;
  final Color text;
  final Color arrowIconBg;
  final Color arrowIconBorder;
  final Color scaffoldBackground;
  final Color timeZoneContainerBorder;
  final Color timeZoneContainerBg;

  const AppColors({
    required this.appBarBg,
    required this.primary,
    required this.secondary,
    required this.background,
    required this.green,
    required this.red,
    required this.text,
    required this.arrowIconBg,
    required this.arrowIconBorder,
    required this.scaffoldBackground,
    required this.timeZoneContainerBorder,
    required this.timeZoneContainerBg,
  });

  @override
  ThemeExtension<AppColors> lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) return this;

    return AppColors(
      appBarBg: Color.lerp(appBarBg, other.appBarBg, t)!,
      primary: Color.lerp(primary, other.primary, t)!,
      secondary: Color.lerp(secondary, other.secondary, t)!,
      background: Color.lerp(background, other.background, t)!,
      green: Color.lerp(background, other.green, t)!,
      red: Color.lerp(background, other.red, t)!,
      text: Color.lerp(text, other.text, t)!,
      arrowIconBg: Color.lerp(arrowIconBg, other.arrowIconBg, t)!,
      arrowIconBorder: Color.lerp(arrowIconBorder, other.arrowIconBorder, t)!,
      scaffoldBackground:
          Color.lerp(scaffoldBackground, other.scaffoldBackground, t)!,
      timeZoneContainerBorder: Color.lerp(
          timeZoneContainerBorder, other.timeZoneContainerBorder, t)!,
      timeZoneContainerBg:
          Color.lerp(timeZoneContainerBg, other.timeZoneContainerBg, t)!,
    );
  }

  @override
  AppColors copyWith({
    Color? appBarBg,
    Color? primary,
    Color? secondary,
    Color? background,
    Color? green,
    Color? red,
    Color? text,
    Color? arrowIconBg,
    Color? arrowIconBorder,
    Color? scaffoldBackground,
    Color? timeZoneContainerBorder,
    Color? timeZoneContainerBg,
  }) {
    return AppColors(
      appBarBg: appBarBg ?? this.appBarBg,
      primary: primary ?? this.primary,
      secondary: secondary ?? this.secondary,
      background: background ?? this.background,
      green: green ?? this.green,
      red: red ?? this.red,
      text: text ?? this.text,
      arrowIconBg: arrowIconBg ?? this.arrowIconBg,
      arrowIconBorder: arrowIconBorder ?? this.arrowIconBorder,
      scaffoldBackground: scaffoldBackground ?? this.scaffoldBackground,
      timeZoneContainerBorder:
          timeZoneContainerBorder ?? this.timeZoneContainerBorder,
      timeZoneContainerBg: timeZoneContainerBg ?? this.timeZoneContainerBg,
    );
  }

  factory AppColors.light() => const AppColors(
        appBarBg: Color(0xFFD4DEF1),
        primary: Colors.white,
        secondary: Colors.lightBlueAccent,
        background: Colors.white,
        green: Color.fromARGB(255, 54, 149, 59),
        red: Color.fromARGB(255, 126, 26, 26),
        text: Colors.black,
        arrowIconBg: Color(0xFFD4DEF1),
        arrowIconBorder: Color(0xFFD4DEF1),
        scaffoldBackground: Colors.white,
        timeZoneContainerBorder: Colors.black,
        timeZoneContainerBg: Colors.transparent,
      );

  factory AppColors.dark() => const AppColors(
        appBarBg: Color(0xFF293A89),
        primary: Colors.deepPurple,
        secondary: Colors.purpleAccent,
        background: Colors.black,
        green: Color.fromARGB(255, 119, 188, 122),
        red: Color.fromARGB(255, 255, 45, 45),
        text: Colors.white,
        arrowIconBg: Color(0xFF293A89),
        arrowIconBorder: Color(0xFF293A89),
        scaffoldBackground: Color(0xFF002359),
        timeZoneContainerBorder: Color(0xFF293A89),
        timeZoneContainerBg: Color(0xFF293A89),
      );
}
