import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/create_biometric.dart';
import './create_biometric_user_dto.dart';

part 'create_biometric_dto.freezed.dart';
part 'create_biometric_dto.g.dart';

@freezed
class CreateBiometricDto with _$CreateBiometricDto {
  const factory CreateBiometricDto({
    String? deviceId,
    String? imei,
    int? customerNo,
    int? userNo,
    CreateBiometricUserDto? user,
    String? isBioExpired,
    dynamic? oldDeviceId,
    String? bioEnabled,
    String? dateCreated,
    dynamic? dateModified,
    String? createdBy,
    dynamic? modifiedBy,
  }) = _CreateBiometricDto;

  factory CreateBiometricDto.fromJson(Map<String, dynamic> json) => _$CreateBiometricDtoFromJson(json);
}

extension CreateBiometricDtoX on CreateBiometricDto {
  CreateBiometric toEntity() => CreateBiometric(
      deviceId: deviceId ?? "",
      imei: imei ?? "",
      customerNo: customerNo ?? 0,
      userNo: userNo ?? 0,
      user: user?.toEntity(),
      isBioExpired: isBioExpired ?? "",
      oldDeviceId: oldDeviceId,
      bioEnabled: bioEnabled ?? "",
      dateCreated: dateCreated ?? "",
      dateModified: dateModified,
      createdBy: createdBy ?? "",
      modifiedBy: modifiedBy,
  );
}
