import 'package:flutter/material.dart';
import 'package:optimus_case/models/localization_strings.dart';
import 'package:optimus_case/utils/extensions.dart/theme_extension.dart';

class ConnectionStatusWidget extends StatelessWidget {
  final bool isCheckingConnection;
  final bool isConnected;

  const ConnectionStatusWidget({
    required this.isCheckingConnection,
    required this.isConnected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final color = isCheckingConnection
        ? context.themeColors.primary
        : isConnected
            ? context.themeColors.green
            : context.themeColors.red;

    final icon = isCheckingConnection
        ? Icons.hourglass_empty
        : isConnected
            ? Icons.check_circle_outline
            : Icons.error_outline;

    final text = isCheckingConnection
        ? LocalizationStrings.checkingConnection
        : isConnected
            ? LocalizationStrings.internetConnectionApproved
            : LocalizationStrings.nointernetConnection;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: color,
          size: 64,
        ),
        const SizedBox(height: 16),
        Text(
          text,
          style: context.textStyles.bold1.copyWith(color: color),
        ),
      ],
    );
  }
}
