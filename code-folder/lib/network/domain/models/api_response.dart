
import 'package:dkb_retail/common/utils.dart';

import 'api_error.dart';

/// ⚠️ DEPRECATED: Use [ApiEnvelope] + [ApiMapper] instead of [ApiResponse].
///
/// This wrapper was an earlier approach to unify API responses.
/// It will be removed once all datasources are migrated to `ApiEnvelope`.
@Deprecated(
  'Use ApiEnvelope + ApiMapper.fromJson instead. '
      'ApiResponse is kept only for backward compatibility and will be removed soon.',
)
class ApiResponse<T> {
  final T? data;
  final ApiError? status;
  final String? error;
  final String? statusCode;

  ApiResponse({this.data,this.status, this.error, this.statusCode});

  // Factory method to handle success/failure based on status code
  factory ApiResponse.fromJson(
      Map<String, dynamic> json, T Function(dynamic) create) {
    final statusCode = json['status']?['code'];

    consoleLog("Status code ${statusCode}");

    // Success if code is '000000'
    if (statusCode == '000000') {
      return ApiResponse(data: create(json['data']), statusCode: statusCode);
    } else {
      // Handle the error case
      final statusDescription = json['status']?['mwdesc'] ??
          json['status']?['description'] ??
          'Server error';
      return ApiResponse(error: statusDescription, statusCode: statusCode);
    }
  }

  bool get isSuccess => data != null;
}
