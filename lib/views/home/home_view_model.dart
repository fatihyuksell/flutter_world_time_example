import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:optimus_case/base_view_model.dart';
import 'package:optimus_case/routes/static_routes.dart';
import 'package:optimus_case/services/local/theme_manager.dart';
import 'package:optimus_case/services/remote/services/time_information_service/time_information_service.dart';

class HomeViewModel extends BaseViewModel {
  final ThemeManager _themeManager;
  final TimeInformationService _timeInformationService;

  HomeViewModel(this._themeManager, this._timeInformationService);

  final GlobalKey textFieldKey = GlobalKey();

  ThemeMode get themeMode => _themeManager.themeMode;
  String get searchQuery => _searchQuery;
  String get deviceName => _deviceName;
  List<String> get filteredRegionList {
    if (_searchQuery.isNotEmpty && _filteredRegionList.isEmpty) {
      return [];
    }
    return _filteredRegionList.isEmpty ? regionList : _filteredRegionList;
  }

  bool isLoading = true;
  String _deviceName = '';
  double textFieldHeight = 48.0;
  List<String> regionList = [];
  String _searchQuery = '';
  List<String> _filteredRegionList = [];

  void updateSearchQuery(String query) {
    _searchQuery = query;
    _filteredRegionList = regionList
        .where((region) => region.toLowerCase().contains(query.toLowerCase()))
        .toList();
    notify();
  }

  set deviceName(String value) {
    _deviceName = value;
    notify();
  }

  @override
  void onBindingCreated() async {
    await init();
    await calculateTextFieldHeight();
    _filteredRegionList = regionList;
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
      Routes.timeZoneDetails,
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
