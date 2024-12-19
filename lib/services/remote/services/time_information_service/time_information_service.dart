import 'package:dio/dio.dart';
import 'package:optimus_case/services/remote/models/time_zone_details_response.dart';
import 'package:retrofit/retrofit.dart';

part 'time_information_service.g.dart';

@RestApi()
abstract class TimeInformationService {
  static const baseUserPath = '/timezone';

  factory TimeInformationService(Dio dio) = _TimeInformationService;

  @GET(baseUserPath)
  Future<List<String>> getTimezones();

  @GET('$baseUserPath/{region}')
  Future<TimeZoneInfoResponse> getTimeZoneSeperatorEntity({
    @Path('region') required String region,
  });
}
