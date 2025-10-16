import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:db_uicomponents/src/utils/device_info/src/device_model.dart';
import 'update_password2_request_body_dto.dart';

part 'update_password2_request.freezed.dart';
part 'update_password2_request.g.dart';

@freezed
class UpdatePassword2Request with _$UpdatePassword2Request {
  const factory UpdatePassword2Request({
    String? method,
    UpdatePassword2RequestBodyDto? body,
    @JsonKey(ignore: true) DeviceModel? deviceInfo,
  }) = _UpdatePassword2Request;

  factory UpdatePassword2Request.fromJson(Map<String, dynamic> json) =>
      _$UpdatePassword2RequestFromJson(json);
}
