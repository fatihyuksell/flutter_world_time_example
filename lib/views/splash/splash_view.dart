import 'package:flutter/material.dart';
import 'package:optimus_case/models/localization_strings.dart';
import 'package:optimus_case/scaffold_view.dart';
import 'package:optimus_case/services/local/theme_manager.dart';
import 'package:optimus_case/services/remote/services/time_information_service/time_information_service.dart';
import 'package:optimus_case/utils/extensions.dart/theme_extension.dart';
import 'package:optimus_case/utils/locator.dart';
import 'package:optimus_case/view_model_builder.dart';
import 'package:optimus_case/views/splash/splash_view_model.dart';
import 'package:optimus_case/widgets/app_bar_with_search_field.dart';
import 'package:optimus_case/widgets/country_list_item.dart';
import 'package:optimus_case/widgets/empty_list_widget.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SplashViewModel>(
      initViewModel: () => SplashViewModel(
        locator<ThemeManager>(),
        locator<TimeInformationService>(),
      ),
      builder: (context, viewModel) {
        return ScaffoldView(
          backgroundColor: context.themeColors.scaffoldBackground,
          body: Column(
            children: [
              AppBarWithSearch(
                deviceName: viewModel.deviceName,
                textFieldHeight: viewModel.textFieldHeight,
                textFieldKey: viewModel.textFieldKey,
              ),
              Expanded(
                child: viewModel.isLoading
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const CircularProgressIndicator.adaptive(),
                            const SizedBox(height: 16),
                            Text(
                              LocalizationStrings.loading,
                              style: context.textStyles.regular,
                            ),
                          ],
                        ),
                      )
                    : RefreshIndicator(
                        onRefresh: viewModel.onPageRefreshed,
                        child: viewModel.regionList.isNotEmpty
                            ? ListView.separated(
                                padding: const EdgeInsets.all(16),
                                itemCount: viewModel.regionList.length + 1,
                                separatorBuilder: (context, index) =>
                                    const SizedBox(height: 16),
                                itemBuilder: (context, index) {
                                  if (index == viewModel.regionList.length) {
                                    return SizedBox(
                                      height:
                                          MediaQuery.paddingOf(context).bottom,
                                    );
                                  }
                                  final item = viewModel.regionList[index];
                                  return CountryListItem(
                                    item: item,
                                    onItemPressed: viewModel.onItemPressed,
                                  );
                                },
                              )
                            : Center(
                                child: EmptyListWidget(
                                  message:
                                      LocalizationStrings.noRegionAvailable,
                                  onRefresh: viewModel.onPageRefreshed,
                                ),
                              ),
                      ),
              )
            ],
          ),
        );
      },
    );
  }
}
