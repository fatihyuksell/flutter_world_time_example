import 'package:flutter/material.dart';
import 'package:optimus_case/utils/extensions.dart/theme_extension.dart';
import 'package:shimmer/shimmer.dart';

class ReusableTimeContainers extends StatelessWidget {
  final List<String> times;
  final bool isLoading;

  const ReusableTimeContainers({
    super.key,
    required this.times,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double totalPadding = (times.length - 1);
        final double availableWidth = constraints.maxWidth - totalPadding;
        final double containerWidth = availableWidth / (times.length * 2 - 1);

        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(times.length * 2 - 1, (index) {
            if (index.isEven) {
              int timeIndex = index ~/ 2;

              if (isLoading) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Shimmer.fromColors(
                    baseColor: context.themeColors.appBarBg.withOpacity(0.3),
                    highlightColor:
                        context.themeColors.appBarBg.withOpacity(0.6),
                    child: Container(
                      width: containerWidth,
                      height: containerWidth,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: context.themeColors.timeZoneShimmerColor,
                        border: Border.all(
                          width: 2,
                          color: context.themeColors.timeZoneContainerBorder,
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                );
              }

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Container(
                  width: containerWidth,
                  height: containerWidth,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: context.themeColors.timeZoneContainerBg,
                    border: Border.all(
                      width: 2,
                      color: context.themeColors.timeZoneContainerBorder,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    transitionBuilder: (child, animation) {
                      return FadeTransition(
                        opacity: animation,
                        child: child,
                      );
                    },
                    child: Text(
                      times[timeIndex],
                      key: ValueKey(times[timeIndex]),
                      style: context.textStyles.hoursAndMinuteText,
                    ),
                  ),
                ),
              );
            } else {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  ":",
                  style: context.textStyles.hoursAndMinuteText,
                ),
              );
            }
          }),
        );
      },
    );
  }
}
