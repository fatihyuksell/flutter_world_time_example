import 'package:flutter/material.dart';
import 'package:optimus_case/services/local/theme_manager.dart';
import 'package:provider/provider.dart';

class RippleThemeToggle extends StatefulWidget {
  const RippleThemeToggle({super.key});

  @override
  State<RippleThemeToggle> createState() => _RippleThemeToggleState();
}

class _RippleThemeToggleState extends State<RippleThemeToggle>
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
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(width: 16),
            ScaleTransition(
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
                    color:
                        themeManager.isDarkMode ? Colors.white : Colors.black,
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
                    themeManager.isDarkMode ? Icons.wb_sunny : Icons.dark_mode,
                    color:
                        themeManager.isDarkMode ? Colors.amber : Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ),
          ],
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
