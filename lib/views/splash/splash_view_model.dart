import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:optimus_case/base_view_model.dart';
import 'package:optimus_case/routes/static_routes.dart';
import 'package:optimus_case/services/local/theme_manager.dart';
import 'package:optimus_case/services/remote/services/time_information_service/time_information_service.dart';

class SplashViewModel extends BaseViewModel {
  final ThemeManager _themeManager;
  final TimeInformationService _timeInformationService;

  SplashViewModel(this._themeManager, this._timeInformationService);

  ThemeMode get themeMode => _themeManager.themeMode;

  String _deviceName = '';
  String get deviceName => _deviceName;

  final GlobalKey textFieldKey = GlobalKey();
  double textFieldHeight = 48.0;

  List<String> regionList = [];

  set deviceName(String value) {
    _deviceName = value;
    notify();
  }

  bool isLoading = true;

  @override
  void onBindingCreated() async {
    await init();
    await calculateTextFieldHeight();
  }

  Future<void> init() async {
    await getRegionDetails();
    await getDeviceInfo();
  }

  Future<void> toggleTheme(ThemeMode mode) async {
    await _themeManager.toggleTheme(mode);
    notify();
  }

  Future<void> getRegionDetails() async {
    isLoading = true;
    notify();

    await flow(
      () async {
        final response = await _timeInformationService.getTimezones();

        if (response.isNotEmpty) {
          regionList = response;
        } else {
          regionList.clear();
        }
        debugPrint('$response');
      },
    );

    isLoading = false;
    notify();
  }

  Future<void> getDeviceInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      deviceName = androidInfo.model;
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      deviceName = iosInfo.model;
    } else {
      deviceName = '';
    }
  }

  Future<void> calculateTextFieldHeight() async {
    await Future.delayed(const Duration(milliseconds: 100), () {
      textFieldHeight = 48.0;
      notify();
    });
  }

  void onItemPressed(String region) {
    navigate(
      Routes.clocks,
      args: region,
    );
  }

  Future<void> onPageRefreshed() async {
    isLoading = true;
    notify();

    regionList.clear();
    await init();

    isLoading = false;
    notify();
  }
}
