import 'package:freezed_annotation/freezed_annotation.dart';


part 'register_biometric_request_request_info_dto.freezed.dart';
part 'register_biometric_request_request_info_dto.g.dart';

@freezed
class RegisterBiometricRequestRequestInfoDto with _$RegisterBiometricRequestRequestInfoDto {
  const factory RegisterBiometricRequestRequestInfoDto({
    String? deviceId,
    String? imei,
    int? userNo,
    int? customerNo,
    String? bioEnabled,
    String? isBioExpired,
    String? createdBy,
  }) = _RegisterBiometricRequestRequestInfoDto;

  factory RegisterBiometricRequestRequestInfoDto.fromJson(Map<String, dynamic> json) => _$RegisterBiometricRequestRequestInfoDtoFromJson(json);
}
