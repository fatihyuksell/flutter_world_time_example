import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:optimus_case/base_view_model.dart';
import 'package:optimus_case/routes/static_routes.dart';

class SplashViewModel extends BaseViewModel {
  bool isConnected = false;
  bool isCheckingConnection = true;

  @override
  void onBindingCreated() {
    checkInternetConnection();
  }

  Future<void> checkInternetConnection() async {
    isCheckingConnection = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 1));
    var connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.none) {
      isConnected = false;
    } else {
      isConnected = true;
      navigateToHome();
    }

    isCheckingConnection = false;
    notifyListeners();
  }

  Future<void> navigateToHome() async {
    await Future.delayed(
      const Duration(seconds: 1),
      () {
        navigate(
          Routes.home,
          clearStack: true,
        );
      },
    );
  }
}
