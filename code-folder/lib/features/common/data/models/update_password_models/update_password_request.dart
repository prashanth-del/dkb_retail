import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:db_uicomponents/src/utils/device_info/src/device_model.dart';
import 'update_password_request_body_dto.dart';

part 'update_password_request.freezed.dart';
part 'update_password_request.g.dart';

@freezed
class UpdatePasswordRequest with _$UpdatePasswordRequest {
  const factory UpdatePasswordRequest({
    String? method,
    UpdatePasswordRequestBodyDto? body,
    @JsonKey(ignore: true) DeviceModel? deviceInfo,
  }) = _UpdatePasswordRequest;

  factory UpdatePasswordRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdatePasswordRequestFromJson(json);
}
