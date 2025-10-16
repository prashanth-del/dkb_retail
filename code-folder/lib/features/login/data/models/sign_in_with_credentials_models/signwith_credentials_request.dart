import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:db_uicomponents/src/utils/device_info/src/device_model.dart';
import 'signwith_credentials_request_body_dto.dart';

part 'signwith_credentials_request.freezed.dart';
part 'signwith_credentials_request.g.dart';

@freezed
class SignwithCredentialsRequest with _$SignwithCredentialsRequest {
  const factory SignwithCredentialsRequest({
    String? method,
    SignwithCredentialsRequestBodyDto? body,
    @JsonKey(ignore: true) DeviceModel? deviceInfo,
  }) = _SignwithCredentialsRequest;

  factory SignwithCredentialsRequest.fromJson(Map<String, dynamic> json) =>
      _$SignwithCredentialsRequestFromJson(json);
}
