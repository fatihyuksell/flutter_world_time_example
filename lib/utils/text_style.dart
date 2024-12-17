import 'package:flutter/material.dart';

class TextStyles extends ThemeExtension<TextStyles> {
  final TextStyle regular;
  final TextStyle bold1;
  final TextStyle bold2;

  const TextStyles({
    required this.regular,
    required this.bold1,
    required this.bold2,
  });

  @override
  ThemeExtension<TextStyles> lerp(
    ThemeExtension<TextStyles>? other,
    double t,
  ) {
    return this;
  }

  @override
  TextStyles copyWith({
    TextStyle? regular,
    TextStyle? bold1,
    TextStyle? bold2,
  }) {
    return TextStyles(
      regular: regular ?? this.regular,
      bold1: bold1 ?? this.bold1,
      bold2: bold2 ?? this.bold2,
    );
  }

  factory TextStyles.light() => const TextStyles(
        regular: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w400,
          color: Colors.black,
          height: 1.33,
        ),
        bold1: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w700,
          height: 1.33,
          color: Colors.black,
        ),
        bold2: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          height: 1.33,
          color: Colors.black,
        ),
      );

  factory TextStyles.dark() => const TextStyles(
        regular: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w400,
          color: Colors.white,
          height: 1.33,
        ),
        bold1: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w700,
          height: 1.33,
          color: Colors.white,
        ),
        bold2: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          height: 1.33,
          color: Colors.white,
        ),
      );
}
