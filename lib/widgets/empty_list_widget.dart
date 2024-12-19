import 'package:flutter/material.dart';
import 'package:optimus_case/models/localization_strings.dart';
import 'package:optimus_case/utils/extensions.dart/theme_extension.dart';

class EmptyListWidget extends StatelessWidget {
  final String message;
  final Future<void> Function() onRefresh;

  const EmptyListWidget({
    super.key,
    required this.message,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          message,
          style: context.textStyles.body1,
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: onRefresh,
          child: Text(
            LocalizationStrings.refresh,
            style: context.textStyles.body1,
          ),
        ),
      ],
    );
  }
}
