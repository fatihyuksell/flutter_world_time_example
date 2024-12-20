import 'package:flutter/material.dart' show ThemeData;

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
}
