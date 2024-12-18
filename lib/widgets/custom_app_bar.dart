import 'package:flutter/material.dart';
import 'package:optimus_case/utils/extensions.dart/theme_extension.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? leading;
  final Widget? trailing;
  final String? title;
  final double borderRadius;
  final Color backgroundColor;

  const CustomAppBar({
    this.leading,
    this.trailing,
    this.title,
    this.borderRadius = 16.0,
    this.backgroundColor = Colors.blue,
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
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 24,
          ),
          constraints: const BoxConstraints(
            minHeight: 56,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (leading != null) leading! else const SizedBox.shrink(),
              Expanded(
                child: Center(
                  child: Text(
                    title ?? '',
                    style: context.textStyles.regular.copyWith(
                      color: context.themeColors.text,
                    ),
                  ),
                ),
              ),
              if (trailing != null) trailing! else const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kTextTabBarHeight);
}
