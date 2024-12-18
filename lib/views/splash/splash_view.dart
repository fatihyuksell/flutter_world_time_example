import 'package:flutter/material.dart';
import 'package:optimus_case/scaffold_view.dart';
import 'package:optimus_case/services/local/theme_manager.dart';
import 'package:optimus_case/utils/extensions.dart/theme_extension.dart';
import 'package:optimus_case/utils/locator.dart';
import 'package:optimus_case/view_model_builder.dart';
import 'package:optimus_case/views/splash/splash_view_model.dart';
import 'package:optimus_case/widgets/app_bar_with_search_field.dart';
import 'package:optimus_case/widgets/country_list_item.dart';

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
          backgroundColor: context.themeColors.scaffoldBackground,
          body: Column(
            children: [
              AppBarWithSearch(
                deviceName: viewModel.deviceName,
                textFieldHeight: viewModel.textFieldHeight,
                textFieldKey: viewModel.textFieldKey,
              ),
              Expanded(
                child: ListView.separated(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(16),
                  itemCount: 10,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    return CountryListItem(
                      itemIndex: index,
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
