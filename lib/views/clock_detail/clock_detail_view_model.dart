import 'package:flutter/material.dart';
import 'package:optimus_case/base_view_model.dart';
import 'package:optimus_case/services/remote/services/time_information_service/time_information_service.dart';

class ClockDetailViewModel extends BaseViewModel {
  final TimeInformationService _timeInformationService;

  ClockDetailViewModel(this._timeInformationService);

  @override
  void onBindingCreated() {
    debugPrint(_timeInformationService.toString());
  }
}
