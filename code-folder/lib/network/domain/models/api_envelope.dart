import '../../data/model/app_status.dart';
import 'api_error.dart';

class ApiEnvelope<T> {
  final T? data;
  final ApiError status;
  final AppStatus appStatus;

  const ApiEnvelope._(this.data, this.status, this.appStatus);

  factory ApiEnvelope.success(T data, ApiError status, AppStatus appStatus) =>
      ApiEnvelope._(data, status, appStatus);

  factory ApiEnvelope.error(ApiError status, AppStatus appStatus) =>
      ApiEnvelope._(null, status, appStatus);

  bool get ok => appStatus == AppStatus.success;

  /// Always user-friendly
  String get message =>
      ok ? (status.mwdesc ?? status.description ?? '')
          : (status.mwdesc ?? status.description ?? 'Something went wrong. Please try again.');
}
