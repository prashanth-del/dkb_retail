import 'package:freezed_annotation/freezed_annotation.dart';


part 'biometriclogin_request_body_raw_dto.freezed.dart';
part 'biometriclogin_request_body_raw_dto.g.dart';

@freezed
class BiometricloginRequestBodyRawDto with _$BiometricloginRequestBodyRawDto {
  const factory BiometricloginRequestBodyRawDto({
    String? userId,
    String? deviceId,
    String? imei,
  }) = _BiometricloginRequestBodyRawDto;

  factory BiometricloginRequestBodyRawDto.fromJson(Map<String, dynamic> json) => _$BiometricloginRequestBodyRawDtoFromJson(json);
}
