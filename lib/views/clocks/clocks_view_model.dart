import 'dart:async';

import 'package:optimus_case/base_view_model.dart';
import 'package:optimus_case/services/remote/models/time_zone_details_response.dart';
import 'package:optimus_case/services/remote/services/time_information_service/time_information_service.dart';
import 'package:optimus_case/utils/extensions.dart/date_format_extension.dart';
import 'package:optimus_case/views/clocks/time_zone_seperator_entity.dart';

class ClocksViewModel extends BaseViewModel<String> {
  final TimeInformationService _timeInformationService;

  ClocksViewModel(this._timeInformationService);

  TimeZoneInfoResponse? timeZoneInfoResponse;
  DateTime? currentTime;
  Timer? _timer;
  bool isLoading = true;
  bool hasError = false; // Flag to track errors

  String get region => args;

  TimeZoneSeperatorEntity get timeZoneSeperatorEntity {
    final parts = region.split('/');
    return TimeZoneSeperatorEntity(area: parts[0], region: parts[1]);
  }

  List<String> get containerTimes => [
        currentTime?.hour.toString().padLeft(2, '0') ?? '00',
        currentTime?.minute.toString().padLeft(2, '0') ?? '00',
      ];

  String? get monthDayYear => currentTime?.toFormattedMonthDayYear();

  String? get dayWithUtcOffset {
    if (currentTime == null || timeZoneInfoResponse == null) return null;
    return currentTime
        ?.toFormattedDayWithUtcOffset(timeZoneInfoResponse!.utcOffset);
  }

  @override
  void onBindingCreated() {
    init();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void init() {
    getRegionDetails();
  }

  Future<void> getRegionDetails() async {
    isLoading = true;
    hasError = false; // Reset the error state
    notifyListeners();

    try {
      final response = await _timeInformationService.getTimeZoneSeperatorEntity(
          region: region);

      timeZoneInfoResponse = response;

      final parsedTime = DateTime.parse(response.datetime);
      final offset = _parseUtcOffset(response.utcOffset);
      currentTime = parsedTime.add(offset);

      _startTimer();
    } catch (e) {
      hasError = true; // If there's an error, update the error state
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Duration _parseUtcOffset(String offsetString) {
    final parts = offsetString.split(':');
    final hours = int.parse(parts[0]);
    final minutes = int.parse(parts[1]);

    return Duration(hours: hours, minutes: minutes);
  }

  void _startTimer() {
    if (currentTime != null) {
      _timer = Timer.periodic(const Duration(seconds: 1), (_) {
        currentTime = currentTime!.add(const Duration(seconds: 1));
        notifyListeners();
      });
    }
  }
}
