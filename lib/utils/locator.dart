import 'package:get_it/get_it.dart';
import 'package:optimus_case/app_repository.dart';

import 'package:optimus_case/services/local/shared_preferences_manager.dart';
import 'package:optimus_case/services/local/theme_manager.dart';
import 'package:optimus_case/services/remote/dio_client.dart';
import 'package:optimus_case/services/remote/services/time_information_service/time_information_service.dart';

final locator = GetIt.I;

void setupDependencyInjection() {
  //ApiClient, Repository,  Register your services here

  locator.registerLazySingleton<SharedPreferenceManager>(
    () => SharedPreferenceManager(),
  );

  // TODO: Can be example for DI necessity
  locator.registerLazySingleton<ThemeManager>(
    () => ThemeManager(
      locator<SharedPreferenceManager>(),
    ),
  );

  locator.registerLazySingleton<AppRepository>(
    () => AppRepository(),
  );

  locator.registerLazySingleton<TimeInformationService>(
    () => TimeInformationService(DioClient.init()),
  );
}
