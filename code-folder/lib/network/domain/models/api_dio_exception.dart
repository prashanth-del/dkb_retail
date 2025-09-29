import 'package:dio/dio.dart';

class ApiDioException extends DioException {
  ApiDioException({
    required super.requestOptions,
    super.response,
    super.type,
    dynamic super.error,
  });

  @override
  String toString() => "$error";
}

class ApiNotFoundError extends ApiDioException {
  ApiNotFoundError({
    required super.requestOptions,
    super.response,
    super.type,
    super.error,
  });
}