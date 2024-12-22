import 'package:flutter/material.dart';
import 'package:optimus_case/models/localization_strings.dart';
import 'package:optimus_case/scaffold_view.dart';
import 'package:optimus_case/services/local/shared_preferences_manager.dart';
import 'package:optimus_case/services/local/theme_manager.dart';
import 'package:optimus_case/services/remote/services/time_information_service/time_information_service.dart';
import 'package:optimus_case/utils/extensions.dart/theme_extension.dart';
import 'package:optimus_case/utils/locator.dart';
import 'package:optimus_case/view_model_builder.dart';
import 'package:optimus_case/views/home/home_view_model.dart';
import 'package:optimus_case/widgets/app_bar_with_search_field.dart';
import 'package:optimus_case/widgets/country_list_shimmer_widget.dart';
import 'package:optimus_case/widgets/country_list_item.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>(
      initViewModel: () => HomeViewModel(
        locator<ThemeManager>(),
        locator<TimeInformationService>(),
        locator<SharedPreferenceManager>(),
      ),
      builder: (context, viewModel) {
        return ScaffoldView(
          backgroundColor: context.themeColors.scaffoldBackground,
          body: Column(
            children: [
              AppBarWithSearch(
                tutorialForNameKey: viewModel.searchKey,
                deviceName: viewModel.deviceName,
                textFieldHeight: viewModel.textFieldHeight,
                enabled: !viewModel.isLoading,
                searchController: viewModel.searchController,
                updateSearchQuery: viewModel.updateSearchQuery,
                onPressedChangedUsername: viewModel.onPressedChangedUsername,
              ),
              Expanded(
                child: RefreshIndicator(
                  displacement: 20,
                  key: viewModel.listKey,
                  onRefresh: viewModel.onPageRefreshed,
                  child: viewModel.isLoading
                      ? const CountryListItemShimmer()
                      : viewModel.isSearchEmpty
                          ? Center(
                              child: Text(
                                LocalizationStrings.notFoundResult,
                                style: context.textStyles.regular,
                              ),
                            )
                          : ListView.separated(
                              padding: const EdgeInsets.all(16),
                              itemCount: viewModel.filteredRegionList.length,
                              separatorBuilder: (context, index) =>
                                  const SizedBox(height: 16),
                              itemBuilder: (context, index) {
                                final item =
                                    viewModel.filteredRegionList[index];
                                return CountryListItem(
                                  item: item,
                                  onItemPressed: viewModel.onItemPressed,
                                );
                              },
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
