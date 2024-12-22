import 'package:flutter/material.dart';
import 'package:optimus_case/utils/extensions.dart/theme_extension.dart';

class ReusableElevatedButton extends StatelessWidget {
  final String text;
  final void Function() onPressed;
  final Widget? prefix;
  final Widget? suffix;
  final bool expanded;
  final bool enabled;
  final double borderRadius;

  const ReusableElevatedButton({
    required this.text,
    required this.onPressed,
    this.prefix,
    this.suffix,
    this.borderRadius = 12,
    this.expanded = false,
    this.enabled = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? onPressed : null,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 16,
        ),
        decoration: BoxDecoration(
          color: enabled
              ? context.themeColors.scaffoldBackground
              : context.themeColors.primary,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: expanded ? MainAxisSize.max : MainAxisSize.min,
          children: [
            if (prefix != null) ...[prefix!, const SizedBox(height: 8)],
            Flexible(
              child: Text(
                text,
                textAlign: TextAlign.center,
              ),
            ),
            if (suffix != null) ...[const SizedBox(width: 8), suffix!],
          ],
        ),
      ),
    );
  }
}
