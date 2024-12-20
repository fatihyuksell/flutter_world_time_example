import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:optimus_case/models/localization_strings.dart';
import 'package:optimus_case/utils/extensions.dart/theme_extension.dart';

class OptimusLogo extends StatefulWidget {
  final double? height;

  const OptimusLogo({this.height = 78, super.key});

  factory OptimusLogo.small() => OptimusLogo(height: 36.h);
  factory OptimusLogo.verySmall() => OptimusLogo(height: 24.h);

  @override
  State<OptimusLogo> createState() => _OptimusLogoState();
}

class _OptimusLogoState extends State<OptimusLogo>
    with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late AnimationController _rotationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();

    _scaleController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeInOut),
    );

    _rotationController = AnimationController(
      duration: const Duration(seconds: 6),
      vsync: this,
    )..repeat();

    _rotationAnimation = Tween<double>(begin: 0, end: 2 * 3.14159).animate(
      CurvedAnimation(parent: _rotationController, curve: Curves.linear),
    );
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedBuilder(
          animation: Listenable.merge([_scaleController, _rotationController]),
          builder: (context, child) {
            return Transform.rotate(
              angle: _rotationAnimation.value,
              child: Transform.scale(
                scale: _scaleAnimation.value,
                child: SvgPicture.asset(
                  'assets/ic_optimus_logo.svg',
                  height: widget.height,
                ),
              ),
            );
          },
        ),
        const SizedBox(
          width: 20,
        ),
        Text(
          LocalizationStrings.optimusSoftware,
          style: context.textStyles.bold2,
        ),
      ],
    );
  }
}
