import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:optimus_case/models/localization_strings.dart';
import 'package:optimus_case/utils/date_format_pattern.dart';
import 'package:optimus_case/utils/extensions.dart/theme_extension.dart';
import 'package:optimus_case/widgets/custom_app_bar.dart';
import 'package:optimus_case/widgets/ripple_theme_toggle.dart';

class AppBarWithSearch extends StatelessWidget {
  final String deviceName;
  final GlobalKey tutorialForNameKey;
  final TextEditingController searchController;
  final double textFieldHeight;
  final bool enabled;
  final void Function(String) updateSearchQuery;
  final void Function(String) onPressedChangedUsername;

  const AppBarWithSearch({
    required this.tutorialForNameKey,
    required this.deviceName,
    required this.searchController,
    required this.textFieldHeight,
    required this.enabled,
    required this.updateSearchQuery,
    required this.onPressedChangedUsername,
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
                  leading: Expanded(
                    child: Column(
                      key: tutorialForNameKey,
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () => onPressedChangedUsername(deviceName),
                          child: Text(
                            '${LocalizationStrings.gM}, $deviceName',
                            style: context.textStyles.semiBold,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          DateFormat(
                            DateFormatPattern.time,
                          ).format(
                            DateTime.now().toLocal(),
                          ),
                          style: context.textStyles.headline1,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
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
                  ),
                  trailing: const RippleThemeToggle(),
                  borderRadius: 24,
                ),
                Positioned(
                  bottom: -(textFieldHeight / 2),
                  left: 16,
                  right: 26,
                  child: TextFormField(
                    enabled: enabled,
                    controller: searchController,
                    style: context.textStyles.body2.copyWith(
                      color: Colors.black,
                    ),
                    onChanged: updateSearchQuery,
                    decoration: InputDecoration(
                      hintText: LocalizationStrings.search,
                      hintStyle: context.textStyles.body2.copyWith(
                        color: Colors.black,
                      ),
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Colors.black,
                      ),
                      labelStyle: context.textStyles.body2.copyWith(
                        color: Colors.black,
                      ),
                      filled: true,
                      fillColor:
                          enabled ? Colors.white : const Color(0xFF687181),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
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
