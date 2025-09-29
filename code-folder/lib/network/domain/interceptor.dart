import 'package:dio/dio.dart';

abstract class Interceptor {
  InterceptorsWrapper get interceptorsWrapper;

  void onRequest(RequestOptions options, RequestInterceptorHandler handler);
  void onResponse(Response response, ResponseInterceptorHandler handler);
  void onError(DioException error, ErrorInterceptorHandler handler);
}