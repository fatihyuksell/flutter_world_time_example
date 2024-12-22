import 'package:equatable/equatable.dart';

class TimeZoneInfoResponse extends Equatable {
  final String utcOffset;
  final String timezone;
  final int dayOfWeek;
  final int dayOfYear;
  final String datetime;
  final String utcDatetime;
  final int unixtime;
  final int rawOffset;
  final int weekNumber;
  final bool dst;
  final String abbreviation;
  final int dstOffset;
  final String? dstFrom;
  final String? dstUntil;
  final String clientIp;

  const TimeZoneInfoResponse({
    required this.utcOffset,
    required this.timezone,
    required this.dayOfWeek,
    required this.dayOfYear,
    required this.datetime,
    required this.utcDatetime,
    required this.unixtime,
    required this.rawOffset,
    required this.weekNumber,
    required this.dst,
    required this.abbreviation,
    required this.dstOffset,
    this.dstFrom,
    this.dstUntil,
    required this.clientIp,
  });

  factory TimeZoneInfoResponse.fromJson(Map<String, dynamic> json) {
    return TimeZoneInfoResponse(
      utcOffset: json['utc_offset'],
      timezone: json['timezone'],
      dayOfWeek: json['day_of_week'],
      dayOfYear: json['day_of_year'],
      datetime: json['datetime'],
      utcDatetime: json['utc_datetime'],
      unixtime: json['unixtime'],
      rawOffset: json['raw_offset'],
      weekNumber: json['week_number'],
      dst: json['dst'],
      abbreviation: json['abbreviation'],
      dstOffset: json['dst_offset'],
      dstFrom: json['dst_from'],
      dstUntil: json['dst_until'],
      clientIp: json['client_ip'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'utc_offset': utcOffset,
      'timezone': timezone,
      'day_of_week': dayOfWeek,
      'day_of_year': dayOfYear,
      'datetime': datetime,
      'utc_datetime': utcDatetime,
      'unixtime': unixtime,
      'raw_offset': rawOffset,
      'week_number': weekNumber,
      'dst': dst,
      'abbreviation': abbreviation,
      'dst_offset': dstOffset,
      'dst_from': dstFrom,
      'dst_until': dstUntil,
      'client_ip': clientIp,
    };
  }

  @override
  List<Object?> get props => [
        utcOffset,
        timezone,
        dayOfWeek,
        dayOfYear,
        datetime,
        utcDatetime,
        unixtime,
        rawOffset,
        weekNumber,
        dst,
        abbreviation,
        dstOffset,
        dstFrom,
        dstUntil,
        clientIp,
      ];
}
