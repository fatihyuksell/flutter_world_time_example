import 'package:flutter/material.dart';
import 'package:optimus_case/scaffold_view.dart';
import 'package:optimus_case/view_model_builder.dart';
import 'package:optimus_case/views/clocks/clocks_view_model.dart';
import 'package:optimus_case/widgets/reusable_app_bar.dart';

class ClocksView extends StatelessWidget {
  const ClocksView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ClocksViewModel>(
      initViewModel: () => ClocksViewModel(),
      builder: (context, viewModel) => ScaffoldView(
        appBar: ReusableAppBar(
          title: 'AppStrings.helpCenter',
          onBackPressed: viewModel.pop,
        ),
        body: Container(),
      ),
    );
  }
}
