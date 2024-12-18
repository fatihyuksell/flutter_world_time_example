import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:optimus_case/base_view_model.dart';
import 'package:optimus_case/routes/static_routes.dart';
import 'package:optimus_case/services/local/theme_manager.dart';

class SplashViewModel extends BaseViewModel {
  final ThemeManager _themeManager;

  SplashViewModel(this._themeManager);

  ThemeMode get themeMode => _themeManager.themeMode;

  String _deviceName = '';
  String get deviceName => _deviceName;

  final GlobalKey textFieldKey = GlobalKey();
  double textFieldHeight = 48.0;

  set deviceName(String value) {
    _deviceName = value;
    notify();
  }

  @override
  void onBindingCreated() async {
    await getDeviceInfo();
    await calculateTextFieldHeight();
  }

  Future<void> toggleTheme(ThemeMode mode) async {
    await _themeManager.toggleTheme(mode);
    notify();
  }

  Future<void> getDeviceInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    switch (Platform.operatingSystem) {
      case 'android':
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        deviceName = androidInfo.model;
        break;
      case 'ios':
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        deviceName = iosInfo.model;
        break;
      default:
        deviceName = '';
    }
  }

  Future<void> calculateTextFieldHeight() async {
    await Future.delayed(const Duration(milliseconds: 100), () {
      textFieldHeight = 48.0;
      notify();
    });
  }

  void onPressedDetails() {
    navigate(Routes.clocks);
  }
}
