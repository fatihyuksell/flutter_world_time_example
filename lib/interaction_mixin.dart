import 'package:flutter/material.dart' show ThemeData;
import 'package:optimus_case/utils/args/dialog_args.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

mixin InteractionMixin {
  late Future<T?>? Function<T extends Object?>(
    String routeName, {
    Object? args,
    bool clearStack,
    bool rootNavigator,
  }) navigate;

  late void Function<T extends Object?>({T result, bool rootNavigator}) pop;

  late void Function(bool loading) loadingOverlay;

  late ThemeData theme;

  late bool Function({bool rootNavigator}) canPop;

  late Future<T?> Function<T extends Object?>(DialogArgs args) dialog;

  late Future<TutorialCoachMark> Function(List<TargetFocus>) tutorial;
}
