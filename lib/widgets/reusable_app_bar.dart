import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:optimus_case/services/local/theme_manager.dart';
import 'package:optimus_case/utils/extensions.dart/text_style_extension.dart';
import 'package:optimus_case/utils/locator.dart';

class ReusableAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final double height;
  final void Function()? onBackPressed;
  final Widget? trailing;
  final Widget? leading;
  final Widget? center;
  final bool showBackButton;

  const ReusableAppBar({
    this.title,
    this.center,
    super.key,
    this.height = 60,
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
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: SafeArea(
        left: false,
        right: false,
        bottom: false,
        child: IntrinsicHeight(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Row(
                children: [
                  if (leading != null)
                    leading!
                  else if (ModalRoute.of(context)?.canPop ?? false)
                    if (showBackButton)
                      IconButton(
                        icon: SvgPicture.asset(
                          'assets/back.svg',
                          height: 24,
                        ),
                        onPressed: onBackPressed,
                        splashRadius: 10,
                      ),
                  if (trailing != null) ...[
                    const Spacer(),
                    trailing!,
                  ],
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: AnimatedSize(
                  duration: const Duration(milliseconds: 200),
                  alignment: Alignment.centerLeft,
                  child: title != null
                      ? Text(
                          title!,
                          style: context.textStyles.regular,
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        )
                      : center != null
                          ? center!
                          : const SizedBox.shrink(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kMinInteractiveDimension);
}
