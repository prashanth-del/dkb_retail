import 'package:dio/dio.dart';
import 'package:dkb_retail/core/errors/exceptions.dart';

import '../constants/app_string.dart';

Exception handleExceptions(Object e) {
  const serverErrorMsg = AppString.serverError;

  if (e is DioException) {
    return _handleDioException(e);
  } else if (e is ServiceException) {
    if (e.message.isNotEmpty) {
      throw e;
    }
    return ServiceException(serverErrorMsg);
  } else if (e is CommonException) {
    throw e;
  } else {
    return GeneralException(serverErrorMsg);
  }
}

Exception _handleDioException(DioException e) {
  switch (e.type) {
    case DioExceptionType.connectionTimeout:
      return NetworkException(AppString.connectionTimeout);
    case DioExceptionType.connectionError:
      return NetworkException(AppString.noInternet);
    default:
      return ServiceException(AppString.serverError);
  }
}
