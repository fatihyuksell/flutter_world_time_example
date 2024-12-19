import 'package:flutter/material.dart';
import 'package:optimus_case/models/localization_strings.dart';
import 'package:optimus_case/scaffold_view.dart';
import 'package:optimus_case/services/remote/services/time_information_service/time_information_service.dart';
import 'package:optimus_case/utils/extensions.dart/theme_extension.dart';
import 'package:optimus_case/utils/locator.dart';
import 'package:optimus_case/view_model_builder.dart';
import 'package:optimus_case/views/clocks/area_detail_entity.dart';
import 'package:optimus_case/views/clocks/clocks_view_model.dart';
import 'package:optimus_case/widgets/area_detail_list.dart';
import 'package:optimus_case/widgets/custom_app_bar.dart';
import 'package:optimus_case/widgets/reusable_time_containers.dart';

class ClocksView extends StatelessWidget {
  const ClocksView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ClocksViewModel>(
      initViewModel: () => ClocksViewModel(
        locator<TimeInformationService>(),
      ),
      builder: (context, viewModel) => ScaffoldView(
        body: ScaffoldView(
          backgroundColor: context.themeColors.scaffoldBackground,
          body: SingleChildScrollView(
            child: Column(
              children: [
                CustomAppBar(
                  verticalPadding: 20,
                  title: LocalizationStrings.worldTime.toUpperCase(),
                ),
                const SizedBox(height: 50),
                if (viewModel.isLoading)
                  const CircularProgressIndicator.adaptive(),
                if (viewModel.hasError)
                  Column(
                    children: [
                      Text(
                        'Failed to load time data. Please try again.',
                        style: context.textStyles.regular3,
                      ),
                      TextButton(
                        onPressed: viewModel.getRegionDetails,
                        child: Text('Retry'),
                      ),
                    ],
                  ),
                if (!viewModel.isLoading &&
                    !viewModel.hasError &&
                    viewModel.currentTime != null)
                  Center(
                    child: Column(
                      children: [
                        ReusableTimeContainers(
                          times: viewModel.containerTimes,
                        ),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: context.themeColors.scaffoldBackground,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: AreaDetailTexts(
                            areaDetailTexts: [
                              AreaDetailEntity(
                                content: viewModel
                                    .timeZoneSeperatorEntity.region
                                    .toUpperCase(),
                                contentStyle: context.textStyles.headline2,
                              ),
                              AreaDetailEntity(
                                content: viewModel.timeZoneSeperatorEntity.area
                                    .toUpperCase(),
                                contentStyle: context.textStyles.regular2,
                              ),
                              AreaDetailEntity(
                                content: viewModel.dayWithUtcOffset ?? '',
                                contentStyle: context.textStyles.regular3,
                              ),
                              AreaDetailEntity(
                                content: viewModel.monthDayYear ?? '',
                                contentStyle: context.textStyles.regular3,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
