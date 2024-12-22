import 'package:flutter/material.dart';
import 'package:optimus_case/utils/args/dialog_args.dart';
import 'package:optimus_case/widgets/default_dialog_widget.dart';

class DialogUtil {
  DialogUtil._();

  static final DialogUtil instance = DialogUtil._();

  final _dialogAnimationTween = Tween<double>(begin: 0.97, end: 1);
  static const toastDuration = Duration(seconds: 2);
  static const alertDuration = Duration(seconds: 3, milliseconds: 400);

  final _dialogTransitionDuration = const Duration(milliseconds: 200);

  Future<T?> dialog<T>(
    final BuildContext context,
    final DialogArgs args,
  ) async {
    return showGeneralDialog<T>(
      context: context,
      barrierLabel: 'Dialog',
      barrierDismissible: args.dismissible,
      transitionDuration: _dialogTransitionDuration,
      pageBuilder: (context, animation, secondaryAnimation) {
        return DefaultDialogWidget(
          dialogArgs: args,
        );
      },
      transitionBuilder: (_, animation, __, child) {
        return ScaleTransition(
          scale: _dialogAnimationTween.animate(
            CurvedAnimation(
              curve: Curves.decelerate,
              reverseCurve: Curves.ease,
              parent: animation,
            ),
          ),
          child: child,
        );
      },
    );
  }
}
