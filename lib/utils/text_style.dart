import 'package:flutter/material.dart';

class TextStyles extends ThemeExtension<TextStyles> {
  final TextStyle regular;
  final TextStyle bold1;
  final TextStyle bold2;
  final TextStyle headline1;
  final TextStyle headline2;
  final TextStyle body1;
  final TextStyle body2;
  final TextStyle caption;
  final TextStyle semiBold;

  const TextStyles({
    required this.regular,
    required this.bold1,
    required this.bold2,
    required this.headline1,
    required this.headline2,
    required this.body1,
    required this.body2,
    required this.caption,
    required this.semiBold,
  });

  @override
  ThemeExtension<TextStyles> lerp(
    ThemeExtension<TextStyles>? other,
    double t,
  ) {
    if (other is! TextStyles) return this;
    return TextStyles(
      regular: TextStyle.lerp(regular, other.regular, t)!,
      bold1: TextStyle.lerp(bold1, other.bold1, t)!,
      bold2: TextStyle.lerp(bold2, other.bold2, t)!,
      headline1: TextStyle.lerp(headline1, other.headline1, t)!,
      headline2: TextStyle.lerp(headline2, other.headline2, t)!,
      body1: TextStyle.lerp(body1, other.body1, t)!,
      body2: TextStyle.lerp(body2, other.body2, t)!,
      caption: TextStyle.lerp(caption, other.caption, t)!,
      semiBold: TextStyle.lerp(semiBold, other.semiBold, t)!,
    );
  }

  @override
  TextStyles copyWith({
    TextStyle? regular,
    TextStyle? bold1,
    TextStyle? bold2,
    TextStyle? headline1,
    TextStyle? headline2,
    TextStyle? body1,
    TextStyle? body2,
    TextStyle? caption,
    TextStyle? semiBold,
  }) {
    return TextStyles(
      regular: regular ?? this.regular,
      bold1: bold1 ?? this.bold1,
      bold2: bold2 ?? this.bold2,
      headline1: headline1 ?? this.headline1,
      headline2: headline2 ?? this.headline2,
      body1: body1 ?? this.body1,
      body2: body2 ?? this.body2,
      caption: caption ?? this.caption,
      semiBold: semiBold ?? this.semiBold,
    );
  }

  factory TextStyles.light() => const TextStyles(
        regular: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: Colors.black,
        ),
        bold1: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: Colors.black,
        ),
        bold2: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: Colors.black,
        ),
        headline1: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        headline2: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
        body1: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Colors.black,
        ),
        body2: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: Colors.black,
        ),
        caption: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w300,
          color: Colors.grey,
        ),
        semiBold: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      );

  factory TextStyles.dark() => const TextStyles(
        regular: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: Colors.white,
        ),
        bold1: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
        bold2: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
        headline1: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        headline2: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        body1: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Colors.white,
        ),
        body2: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: Colors.white,
        ),
        caption: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w300,
          color: Colors.grey,
        ),
        semiBold: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      );
}
