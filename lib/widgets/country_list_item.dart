import 'package:flutter/material.dart';
import 'package:optimus_case/utils/extensions.dart/theme_extension.dart';

class CountryListItem extends StatelessWidget {
  final int itemIndex;

  const CountryListItem({
    required this.itemIndex,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const double circleRadius = 14;

    return Container(
      padding: const EdgeInsets.only(right: circleRadius),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.centerRight,
        children: [
          Container(
            height: 50,
            padding: const EdgeInsets.only(left: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: context.themeColors.appBarBg,
            ),
            child: const Row(
              children: [
                Expanded(
                  child: Text('data'),
                ),
              ],
            ),
          ),
          Positioned(
            right: circleRadius < 16 ? -circleRadius : -16,
            child: Container(
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  width: circleRadius / 4,
                  color: context.themeColors.scaffoldBackground,
                ),
                color: context.themeColors.appBarBg,
              ),
              child: Icon(
                Icons.arrow_forward_ios_rounded,
                size: 18,
                color: context.themeColors.text,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
