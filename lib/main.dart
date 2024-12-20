import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:optimus_case/enums/app_locale.dart';
import 'package:optimus_case/routes/generate_routes.dart';
import 'package:optimus_case/routes/static_routes.dart';
import 'package:optimus_case/services/local/shared_preferences_manager.dart';
import 'package:optimus_case/services/local/theme_manager.dart';
import 'package:optimus_case/utils/locator.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  await runZonedGuarded(() async {
    // TODO: run app Steps inside of there
    WidgetsFlutterBinding.ensureInitialized();
    initializeDateFormatting();
    setupDependencyInjection();

    await locator<SharedPreferenceManager>().init();
    await locator<ThemeManager>().initialize();

    FlutterError.onError = (details) {
      final error = details.exception;
      final stackTrace = details.stack;

      debugPrint('Exception: $error');
      debugPrint('Stack Trace: $stackTrace');

      if (!kDebugMode) {
        //TODO: For production errors, tools can be added from here
      }
    };

    runApp(const Optimus());
  }, (Object error, StackTrace stackTrace) {
    debugPrint('runZonedGuarded: Caught error in my root zone: $error');
    debugPrint('runZonedGuarded: Stack trace: $stackTrace');

    //TODO: For initialization problems (crashlytics, mixpanel etc.) tools can be added from here
  });
}

class Optimus extends StatelessWidget {
  const Optimus({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return ScreenUtilInit(
      minTextAdapt: true,
      designSize: const Size(375, 812),
      builder: (context, child) => ChangeNotifierProvider<ThemeManager>.value(
        value: locator<ThemeManager>(),
        child: Builder(
          builder: (context) {
            final themeManager = context.watch<ThemeManager>();
            return MaterialApp(
              theme: themeManager.lightTheme,
              darkTheme: themeManager.darkTheme,
              themeMode: themeManager.themeMode,
              initialRoute: Routes.splash,
              onGenerateRoute: onGenerateRoute,
              supportedLocales: AppLocale.supportedLocales,
              localizationsDelegates: AppLocale.localizationDelegates,
              //TODO: Cause of animation re-rendering is active for full view
              // for this reason its closed with 0 duration.
              themeAnimationDuration: Duration.zero,
            );
          },
        ),
      ),
    );
  }
}
