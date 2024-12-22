import 'package:flutter/material.dart';
import 'package:optimus_case/utils/app_colors.dart';
import 'package:optimus_case/utils/text_style.dart';

extension ThemeExtensions on BuildContext {
  /// Provides access to the [TextStyles] defined in the current [ThemeData].
  /// Throws an exception if the extension is not added to the theme.
  TextStyles get textStyles {
    final styles = Theme.of(this).extension<TextStyles>();
    if (styles == null) {
      throw Exception(
        'TextStyles extension is not added to the ThemeData. Please ensure it is included.',
      );
    }
    return styles;
  }

  /// Provides access to the [AppColors] defined in the current [ThemeData].
  /// Returns [AppColors.light()] as a fallback if the extension is not found.
  AppColors get themeColors =>
      Theme.of(this).extension<AppColors>() ?? AppColors.light();
}
