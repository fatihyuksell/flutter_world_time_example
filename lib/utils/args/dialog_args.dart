import 'package:flutter/material.dart';
import 'package:optimus_case/models/localization_strings.dart';

class DialogArgs {
  final String title;
  final String? description;
  final String? negativeButtonText;
  final String positiveButtonText;
  final void Function()? onNegativeButtonPressed;
  final void Function()? onPositiveButtonPressed;
  final bool dismissible;
  final bool isNegativeButtonEnabled;
  final String? appBarTitle;
  final String? textFieldText;
  final TextEditingController? manipulateController;

  DialogArgs({
    this.description,
    this.title = '',
    this.negativeButtonText,
    this.onNegativeButtonPressed,
    String? positiveButtonText,
    this.onPositiveButtonPressed,
    this.dismissible = true,
    this.isNegativeButtonEnabled = true,
    this.appBarTitle,
    this.textFieldText,
    this.manipulateController,
  }) : positiveButtonText = positiveButtonText ??= LocalizationStrings.ok;

  factory DialogArgs.takeTheUsername(
    String? textFieldText,
    TextEditingController? manipulateController,
  ) {
    return DialogArgs(
      manipulateController: manipulateController,
      textFieldText: textFieldText,
      dismissible: false,
      title: LocalizationStrings.enterYourName,
    );
  }
}
