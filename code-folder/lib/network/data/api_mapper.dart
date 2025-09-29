import '../domain/models/api_envelope.dart';
import '../domain/models/api_error.dart';
import 'model/generic_list_response.dart';
import 'model/generic_response.dart';
import 'status_policy.dart';

class ApiMapper {
  static ApiEnvelope<T> mapData<T>(
      Map<String, dynamic> json,
      T Function(dynamic) parseT, // closure-friendly `(data) => Model.fromJson(data)`
      ) {
    final resp = GenericResponse<T>.fromJson(json, parseT);
    final st = resp.status ?? const ApiError();
    final app = StatusPolicy.defaultPolicy(st);

    if (resp.isSuccess && resp.data != null) {
      return ApiEnvelope.success(resp.data as T, st, app);
    }
    return ApiEnvelope.error(st, app);
  }

  static ApiEnvelope<void> mapStatusVoid(Map<String, dynamic> json) {
    final statusJson = json['status'];
    final status = statusJson is Map<String, dynamic>
        ? ApiError.fromJson(statusJson)
        : const ApiError();

    final app = StatusPolicy.defaultPolicy(status);

    return status.ok
        ? ApiEnvelope.success(null, status, app)
        : ApiEnvelope.error(status, app);
  }

  static ApiEnvelope<List<T>> mapList<T>(
      Map<String, dynamic> json,
      T Function(dynamic) parseT,
      ) {
    final resp = GenericListResponse<T>.fromJson(json, parseT);
    final st = resp.status ?? const ApiError();
    final app = StatusPolicy.defaultPolicy(st);

    if (resp.isSuccess) {
      return ApiEnvelope.success(resp.data, st, app);
    }
    return ApiEnvelope.error(st, app);
  }
}
