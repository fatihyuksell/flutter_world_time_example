import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';

mixin DioClient {
  static Dio init({String? baseUrl}) {
    final BaseOptions baseOptions = BaseOptions(
      baseUrl: baseUrl ?? 'https://worldtimeapi.org/api',
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: <String, String>{
        HttpHeaders.acceptHeader: 'application/json',
      },
    );

    final client = Dio(baseOptions);

    client.interceptors.addAll([
      InterceptorsWrapper(
        onRequest: _requestInterceptor,
        onResponse: _responseInterceptor,
        onError: _errorInterceptor,
      ),
    ]);
    return client;
  }

  static Future<void> _requestInterceptor(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // TODO: If the requests needs to have JWT token,
    // add the headers inside this block
    log('request uri : ${options.uri}');
    handler.next(options);
  }

  static void _responseInterceptor(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    handler.next(response);
  }

  static void _errorInterceptor(
    DioException error,
    ErrorInterceptorHandler handler,
  ) {
    handler.next(error);
  }
}
