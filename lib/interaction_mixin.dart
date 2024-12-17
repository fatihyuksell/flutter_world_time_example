import 'package:flutter/material.dart' show ThemeData, Widget;

mixin InteractionMixin {
  late Future<T?>? Function<T extends Object?>(
    String routeName, {
    Object? args,
    bool clearStack,
    bool rootNavigator,
  }) navigate;

  late Future<T?>? Function<T extends Object?>(
    String routeName, {
    Object? args,
    Object? result,
    bool rootNavigator,
  }) pushReplacement;

  late Future<T?>? Function<T extends Object?>(
    String routeName, {
    Object? args,
    Object? result,
    bool rootNavigator,
  }) popAndNavigate;

  late void Function<T extends Object?>({T result, bool rootNavigator}) pop;

  late void Function(String routeName, {bool rootNavigator}) popUntilRoute;

  late void Function({
    required String routeName,
    required String defaultRouteName,
    bool root,
  }) popUntilWithDefaultRoute;

  late void Function(bool loading) loadingOverlay;

  late ThemeData theme;

  late Future<T?> Function<T extends Object?>(
    Widget child, {
    bool dismissible,
  }) customDialog;

  late bool Function({bool rootNavigator}) canPop;

  late bool Function() isCurrent;
}
