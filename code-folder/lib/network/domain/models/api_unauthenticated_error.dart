import 'api_dio_exception.dart';

class ApiUnAuthenticatedError extends ApiDioException {
  ApiUnAuthenticatedError({
    required super.requestOptions,
    super.response,
    super.type,
    super.error,
  });
}

class UnAuthenticatedError extends Error {}
