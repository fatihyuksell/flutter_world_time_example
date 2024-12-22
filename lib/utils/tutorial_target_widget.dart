import 'package:flutter/material.dart';
import 'package:optimus_case/services/local/theme_manager.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

class TutorialTargetFocus {
  static TargetFocus createTargetFocus({
    required String identify,
    required GlobalKey keyTarget,
    ShapeLightFocus? focusType,
    String? title,
    String? description,
    ContentAlign align = ContentAlign.bottom,
    TextStyle? titleStyle,
    TextStyle? descriptionStyle,
    required ThemeManager themeManager,
  }) {
    titleStyle ??= const TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 20,
    );

    descriptionStyle ??= const TextStyle(color: Colors.white);

    return TargetFocus(
      shape: focusType ?? ShapeLightFocus.RRect,
      radius: 20,
      identify: identify,
      keyTarget: keyTarget,
      contents: [
        TargetContent(
          align: align,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (title != null)
                Text(
                  title,
                  style: titleStyle,
                ),
              if (title != null) const SizedBox(height: 8),
              if (description != null)
                Text(
                  description,
                  style: descriptionStyle,
                ),
            ],
          ),
        ),
      ],
    );
  }
}
