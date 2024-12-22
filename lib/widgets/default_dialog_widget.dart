import 'package:flutter/material.dart';
import 'package:optimus_case/models/localization_strings.dart';
import 'package:optimus_case/utils/args/dialog_args.dart';
import 'package:optimus_case/utils/args/dialog_result.dart';
import 'package:optimus_case/utils/extensions.dart/theme_extension.dart';
import 'package:optimus_case/widgets/reusable_elevated_button.dart';

class DefaultDialogWidget extends StatefulWidget {
  const DefaultDialogWidget({
    required this.dialogArgs,
    super.key,
  });

  final DialogArgs dialogArgs;

  @override
  State<DefaultDialogWidget> createState() => _DefaultDialogWidgetState();
}

class _DefaultDialogWidgetState extends State<DefaultDialogWidget> {
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize the text controller with the initial textFieldText value.
    _textController.text = widget.dialogArgs.textFieldText ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
          margin: const EdgeInsets.symmetric(
            horizontal: 24,
          ),
          decoration: BoxDecoration(
            color: context.themeColors.scaffoldBackground,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(height: 16),
              Text(
                widget.dialogArgs.title,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * .047,
                  fontWeight: FontWeight.w600,
                  color: context.themeColors.text,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              if (widget.dialogArgs.description != null)
                Text(
                  widget.dialogArgs.description!,
                  style: context.textStyles.regular,
                  textAlign: TextAlign.center,
                ),
              const SizedBox(height: 16),
              TextField(
                autofillHints: const [AutofillHints.name],
                controller:
                    widget.dialogArgs.manipulateController ?? _textController,
                decoration: const InputDecoration(
                  hintText: LocalizationStrings.enterYourName,
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ReusableElevatedButton(
                  text: widget.dialogArgs.positiveButtonText,
                  onPressed: () {
                    Navigator.of(context).pop(
                      DialogResult(
                        isConfirmed: true,
                        text: widget.dialogArgs.manipulateController?.text ??
                            _textController.text,
                      ),
                    );
                    widget.dialogArgs.onPositiveButtonPressed?.call();
                  },
                ),
              ),
              if (widget.dialogArgs.isNegativeButtonEnabled) ...[
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop(
                      DialogResult(
                        isConfirmed: false,
                        text: widget.dialogArgs.textFieldText ?? '',
                      ),
                    );
                    widget.dialogArgs.onNegativeButtonPressed?.call();
                  },
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    color: Colors.transparent,
                    child: Center(
                      child: Text(
                        widget.dialogArgs.negativeButtonText ??
                            LocalizationStrings.cancel,
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
