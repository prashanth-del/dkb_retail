import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/biometric_auth.dart';


part 'biometric_auth_dto.freezed.dart';
part 'biometric_auth_dto.g.dart';

@freezed
class BiometricAuthDto with _$BiometricAuthDto {
  const factory BiometricAuthDto({
    bool? success,
    String? message,
    String? token,
    String? userId,
    String? domainId,
    String? userType,
    String? deviceId,
    dynamic? deviceName,
    String? imei,
  }) = _BiometricAuthDto;

  factory BiometricAuthDto.fromJson(Map<String, dynamic> json) => _$BiometricAuthDtoFromJson(json);
}

extension BiometricAuthDtoX on BiometricAuthDto {
  BiometricAuth toEntity() => BiometricAuth(
      success: success ?? false,
      message: message ?? "",
      token: token ?? "",
      userId: userId ?? "",
      domainId: domainId ?? "",
      userType: userType ?? "",
      deviceId: deviceId ?? "",
      deviceName: deviceName,
      imei: imei ?? "",
  );
}
