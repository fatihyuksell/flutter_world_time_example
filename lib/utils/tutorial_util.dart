import 'package:flutter/material.dart';
import 'package:optimus_case/models/localization_strings.dart';
import 'package:optimus_case/utils/extensions.dart/theme_extension.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

class TutorialCoachMarkUtil {
  TutorialCoachMarkUtil._();

  static final TutorialCoachMarkUtil instance = TutorialCoachMarkUtil._();

  late TutorialCoachMark _tutorialCoachMark;

  TutorialCoachMark showTutorial({
    required BuildContext context,
    required List<TargetFocus> targets,
    String skipText = LocalizationStrings.skip,
    Color shadowColor = Colors.black,
    double shadowOpacity = 0.8,
    void Function()? onFinish,
    void Function(TargetFocus)? onClickTarget,
    bool Function()? onSkip,
    void Function(TargetFocus)? onClickOverlay,
  }) {
    _tutorialCoachMark = TutorialCoachMark(
      textStyleSkip: context.textStyles.regular,
      targets: targets,
      colorShadow: shadowColor.withOpacity(shadowOpacity),
      textSkip: skipText,
      onFinish: onFinish,
      onClickTarget: onClickTarget,
      onSkip: onSkip,
      onClickOverlay: onClickOverlay,
    )..show(context: context);
    return _tutorialCoachMark;
  }
}
