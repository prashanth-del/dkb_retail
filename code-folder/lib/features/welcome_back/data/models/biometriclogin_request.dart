import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:db_uicomponents/src/utils/device_info/src/device_model.dart';
import './biometriclogin_request_body_dto.dart';

part 'biometriclogin_request.freezed.dart';
part 'biometriclogin_request.g.dart';

@freezed
class BiometricloginRequest with _$BiometricloginRequest {
  const factory BiometricloginRequest({
    String? method,
    BiometricloginRequestBodyDto? body,
    @JsonKey(ignore: true) DeviceModel? deviceInfo,
  }) = _BiometricloginRequest;

  factory BiometricloginRequest.fromJson(Map<String, dynamic> json) => _$BiometricloginRequestFromJson(json);
}
