import 'package:flutter/material.dart';
import 'package:optimus_case/scaffold_view.dart';
import 'package:optimus_case/services/remote/services/time_information_service/time_information_service.dart';
import 'package:optimus_case/utils/locator.dart';
import 'package:optimus_case/view_model_builder.dart';
import 'package:optimus_case/views/clock_detail/clock_detail_view_model.dart';

class ClockDetailView extends StatelessWidget {
  const ClockDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ClockDetailViewModel>(
      initViewModel: () => ClockDetailViewModel(
        locator<TimeInformationService>(),
      ),
      builder: (context, viewModel) => const ScaffoldView(
        body: ColoredBox(
          color: Colors.white,
        ),
      ),
    );
  }
}
