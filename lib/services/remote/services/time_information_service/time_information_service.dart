import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'time_information_service.g.dart';

@RestApi()
abstract class TimeInformationService {
  static const baseUserPath = '/timezone';

  factory TimeInformationService(Dio dio) = _TimeInformationService;

  @GET('$baseUserPath/')
  Future<void> getBasePath();
}
