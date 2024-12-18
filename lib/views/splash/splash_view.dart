import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:optimus_case/scaffold_view.dart';
import 'package:optimus_case/services/local/theme_manager.dart';
import 'package:optimus_case/utils/date_format_pattern.dart';
import 'package:optimus_case/utils/extensions.dart/date_format_extension.dart';
import 'package:optimus_case/utils/extensions.dart/theme_extension.dart';
import 'package:optimus_case/utils/locator.dart';
import 'package:optimus_case/view_model_builder.dart';
import 'package:optimus_case/views/splash/splash_view_model.dart';
import 'package:optimus_case/widgets/custom_app_bar.dart';
import 'package:optimus_case/widgets/location_informations.dart';
import 'package:optimus_case/widgets/ripple_theme_toggle.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SplashViewModel>(
      initViewModel: () => SplashViewModel(
        locator<ThemeManager>(),
      ),
      builder: (context, viewModel) {
        return ScaffoldView(
          body: Column(
            children: [
              CustomAppBar(
                leading: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Günaydın,${viewModel.deviceName}',
                      style: context.textStyles.regular.copyWith(
                        color: context.themeColors.text,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      DateFormat(DateFormatPattern.time).format(
                        DateTime.now().toLocal(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      DateFormat(
                              DateFormatPattern.dayMonthCommasDayName, 'tr-TR')
                          .format(
                        DateTime.now().toLocal().addTimeZoneOffset(),
                      ),
                    ),
                  ],
                ),
                trailing: const RippleThemeToggle(),
                borderRadius: 24,
              ),
              Expanded(
                child: Column(
                  children: [
                    if (viewModel.themeMode == ThemeMode.dark) ...[
                      Text(
                        'DARK',
                        style: context.textStyles.regular,
                      )
                    ],
                    if (viewModel.themeMode == ThemeMode.light) ...[
                      Text(
                        'LIGHT',
                        style: context.textStyles.regular,
                      )
                    ],
                    const LocationInformations(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Regular Text',
                          style: context.textStyles.regular,
                        ),
                        GestureDetector(
                          onTap: viewModel.onPressedDetails,
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Text('data'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
