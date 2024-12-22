import 'package:flutter/material.dart';
import 'package:optimus_case/models/localization_strings.dart';
import 'package:optimus_case/utils/extensions.dart/theme_extension.dart';
import 'package:shimmer/shimmer.dart';

class CountryListItemShimmer extends StatelessWidget {
  const CountryListItemShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const double circleRadius = 14;

    return Padding(
      padding: const EdgeInsets.symmetric(
        //Refresh Indicator displacement area on top of each other
        vertical: 100,
        horizontal: 16,
      ),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Container(
            height: 54,
            padding: const EdgeInsets.only(left: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: context.themeColors.scaffoldBackground,
            ),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  LocalizationStrings.loading,
                ),
                Text(
                  LocalizationStrings.loadingUntilServiceCompletion,
                ),
              ],
            ),
          ),
          Shimmer.fromColors(
            baseColor: context.themeColors.appBarBg.withOpacity(0.3),
            highlightColor: context.themeColors.appBarBg.withOpacity(0.6),
            child: Container(
              height: 54,
              padding: const EdgeInsets.only(left: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: context.themeColors.appBarBg,
              ),
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
                color: context.themeColors.text.withOpacity(.3),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
