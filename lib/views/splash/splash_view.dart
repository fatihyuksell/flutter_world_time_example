import 'package:flutter/material.dart';
import 'package:optimus_case/scaffold_view.dart';
import 'package:optimus_case/view_model_builder.dart';
import 'package:optimus_case/views/splash/splash_view_model.dart';
import 'package:optimus_case/widgets/connection_status_widget.dart';
import 'package:optimus_case/widgets/optimus_logo.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SplashViewModel>(
      initViewModel: () => SplashViewModel(),
      builder: (context, viewModel) {
        return ScaffoldView(
          backgroundColor: const Color(0xFF002359),
          body: Stack(
            alignment: Alignment.center,
            children: [
              const Center(
                child: OptimusLogo(),
              ),
              Positioned(
                bottom: 64,
                child: ConnectionStatusWidget(
                  isCheckingConnection: viewModel.isCheckingConnection,
                  isConnected: viewModel.isConnected,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
