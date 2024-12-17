import 'package:flutter/material.dart';
import 'package:optimus_case/utils/text_style.dart';

extension TextStylesExtension on BuildContext {
  TextStyles get textStyles {
    final styles = Theme.of(this).extension<TextStyles>();
    if (styles == null) {
      throw Exception(
        'TextStyles extension is not added to the ThemeData. Please ensure it is included.',
      );
    }
    return styles;
  }
}
