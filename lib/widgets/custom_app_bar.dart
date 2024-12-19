import 'package:flutter/material.dart';
import 'package:optimus_case/utils/extensions.dart/theme_extension.dart';

class CustomAppBar extends StatelessWidget {
  final Widget? leading;
  final Widget? trailing;
  final String? title;
  final double borderRadius;
  final Color backgroundColor;
  final VoidCallback? onBackPressed;
  final double? verticalPadding;

  const CustomAppBar({
    this.leading,
    this.trailing,
    this.title,
    this.borderRadius = 32.0,
    this.backgroundColor = Colors.blue,
    this.onBackPressed,
    this.verticalPadding,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: context.themeColors.appBarBg,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(borderRadius),
          bottomRight: Radius.circular(borderRadius),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Container(
          padding: EdgeInsets.only(
            left: 24,
            right: 24,
            top: verticalPadding ?? 30,
            bottom: verticalPadding ?? 50,
          ),
          constraints: const BoxConstraints(
            minHeight: 56,
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (leading != null)
                    leading!
                  else if (ModalRoute.of(context)?.canPop ?? false)
                    IconButton(
                      onPressed: () => onBackPressed ?? Navigator.pop(context),
                      splashRadius: 20,
                      icon: Icon(
                        Icons.arrow_back_rounded,
                        color: context.themeColors.text,
                        size: 26,
                      ),
                    ),
                  if (trailing != null) trailing! else const SizedBox.shrink(),
                ],
              ),
              if (title != null)
                Text(
                  title!,
                  style: context.textStyles.headline1.copyWith(
                    color: context.themeColors.text,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
