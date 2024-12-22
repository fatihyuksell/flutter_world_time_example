import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:optimus_case/services/local/theme_manager.dart';
import 'package:optimus_case/utils/extensions.dart/theme_extension.dart';
import 'package:optimus_case/utils/locator.dart';

class ReusableAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final void Function()? onBackPressed;
  final Widget? trailing;
  final Widget? leading;
  final Widget? center;
  final bool showBackButton;

  const ReusableAppBar({
    this.title,
    this.center,
    super.key,
    this.onBackPressed,
    this.trailing,
    this.leading,
    this.showBackButton = true,
  });

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      locator<ThemeManager>().themeMode == ThemeMode.dark
          ? SystemUiOverlayStyle.dark
          : SystemUiOverlayStyle.light,
    );

    return Material(
      child: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: context.themeColors.primary,
            boxShadow: const [
              BoxShadow(
                blurRadius: 100.0,
                offset: Offset(1, 4),
              ),
            ],
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(MediaQuery.of(context).size.width),
            ),
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(30),
                  ),
                  shape: BoxShape.rectangle,
                ),
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (leading != null)
                          leading!
                        else if (showBackButton)
                          IconButton(
                            icon: const Icon(Icons.arrow_back),
                            onPressed:
                                onBackPressed ?? () => Navigator.pop(context),
                          ),
                        if (trailing != null) trailing!,
                      ],
                    ),
                    if (title != null) ...[
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          title!,
                          style: context.textStyles.bold2,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                    if (center != null) center!,
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 15);
}
