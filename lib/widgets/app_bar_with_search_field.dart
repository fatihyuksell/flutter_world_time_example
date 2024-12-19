import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:optimus_case/utils/date_format_pattern.dart';
import 'package:optimus_case/utils/extensions.dart/theme_extension.dart';
import 'package:optimus_case/widgets/custom_app_bar.dart';
import 'package:optimus_case/widgets/ripple_theme_toggle.dart';

class AppBarWithSearch extends StatelessWidget {
  final String deviceName;
  final GlobalKey textFieldKey;
  final double textFieldHeight;

  const AppBarWithSearch({
    required this.deviceName,
    required this.textFieldKey,
    required this.textFieldHeight,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                CustomAppBar(
                  leading: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Günaydın, $deviceName',
                        style: context.textStyles.semiBold,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        DateFormat(
                          DateFormatPattern.time,
                        ).format(
                          DateTime.now().toLocal(),
                        ),
                        style: context.textStyles.headline1,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        DateFormat(
                          DateFormatPattern.dayMonthCommasDayName,
                          'tr-TR',
                        ).format(
                          DateTime.now().toLocal(),
                        ),
                        style: context.textStyles.semiBold,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  trailing: const RippleThemeToggle(),
                  borderRadius: 24,
                ),
                Positioned(
                  bottom: -(textFieldHeight / 2),
                  left: 16,
                  right: 16,
                  child: TextFormField(
                    key: textFieldKey,
                    decoration: InputDecoration(
                      hintText: 'Search',
                      hintStyle: context.textStyles.regular.copyWith(
                        color: context.themeColors.text.withOpacity(0.5),
                      ),
                      prefixIcon: const Icon(Icons.search),
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: textFieldHeight / 2),
          ],
        );
      },
    );
  }
}
