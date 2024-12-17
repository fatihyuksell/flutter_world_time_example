import 'package:flutter/material.dart';
import 'package:optimus_case/scaffold_view.dart';
import 'package:optimus_case/services/local/theme_manager.dart';
import 'package:optimus_case/utils/extensions.dart/text_style_extension.dart';
import 'package:optimus_case/utils/locator.dart';
import 'package:optimus_case/view_model_builder.dart';
import 'package:optimus_case/views/splash/splash_view_model.dart';
import 'package:optimus_case/widgets/reusable_app_bar.dart';
import 'package:provider/provider.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SplashViewModel>(
      initViewModel: () => SplashViewModel(
        locator<ThemeManager>(),
      ),
      builder: (context, viewModel) {
        return ScaffoldView(
          appBar: const ReusableAppBar(
            showBackButton: true,
            title: 'Settings',
            trailing: RippleDarkModeToggle(),
          ),
          body: Column(
            children: [
              ListView(
                shrinkWrap: true,
                children: ThemeMode.values.map((mode) {
                  return ListTile(
                    title: Text(mode.toString().split('.').last),
                    trailing: Radio<ThemeMode>(
                      value: mode,
                      splashRadius: 20,
                      toggleable: false,
                      groupValue: viewModel.themeMode,
                      onChanged: (value) async {
                        await viewModel.toggleTheme(value!);
                      },
                    ),
                  );
                }).toList(),
              ),
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
        );
      },
    );
  }
}

class RippleDarkModeToggle extends StatefulWidget {
  const RippleDarkModeToggle({super.key});

  @override
  State<RippleDarkModeToggle> createState() => _RippleDarkModeToggleState();
}

class _RippleDarkModeToggleState extends State<RippleDarkModeToggle>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rippleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _rippleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );
  }

  Future<void> _toggleMode(ThemeManager themeManager) async {
    final newMode = themeManager.isDarkMode ? ThemeMode.light : ThemeMode.dark;
    await themeManager.toggleTheme(newMode);

    _controller.reset();
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeManager>(
      builder: (context, themeManager, child) {
        return ScaleTransition(
          scale: _rippleAnimation,
          child: InkWell(
            onTap: () async {
              await _toggleMode(themeManager);
            },
            customBorder: const CircleBorder(),
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeInOut,
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: themeManager.isDarkMode ? Colors.black : Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade400,
                    blurRadius: 5,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Icon(
                themeManager.isDarkMode ? Icons.dark_mode : Icons.wb_sunny,
                color: themeManager.isDarkMode ? Colors.white : Colors.amber,
                size: 20,
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
