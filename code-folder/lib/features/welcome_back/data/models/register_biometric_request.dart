import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:db_uicomponents/src/utils/device_info/src/device_model.dart';
import './register_biometric_request_request_info_dto.dart';

part 'register_biometric_request.freezed.dart';
part 'register_biometric_request.g.dart';

@freezed
class RegisterBiometricRequest with _$RegisterBiometricRequest {
  const factory RegisterBiometricRequest({
    RegisterBiometricRequestRequestInfoDto? requestInfo,
    @JsonKey(ignore: true) DeviceModel? deviceInfo,
  }) = _RegisterBiometricRequest;

  factory RegisterBiometricRequest.fromJson(Map<String, dynamic> json) => _$RegisterBiometricRequestFromJson(json);
}
