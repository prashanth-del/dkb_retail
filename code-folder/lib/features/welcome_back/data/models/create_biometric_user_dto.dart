import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/create_biometric_user.dart';


part 'create_biometric_user_dto.freezed.dart';
part 'create_biometric_user_dto.g.dart';

@freezed
class CreateBiometricUserDto with _$CreateBiometricUserDto {
  const factory CreateBiometricUserDto({
    int? userNo,
    String? userId,
    String? firstName,
    dynamic? middleName,
    String? lastName,
    String? email,
    String? phoneNo,
    dynamic? customerId,
    dynamic? dateOfBirth,
    String? address,
    String? city,
    String? state,
    String? country,
    String? postalCode,
    dynamic? profilePictureUrl,
    String? domainId,
    String? createdAt,
    String? updatedAt,
  }) = _CreateBiometricUserDto;

  factory CreateBiometricUserDto.fromJson(Map<String, dynamic> json) => _$CreateBiometricUserDtoFromJson(json);
}

extension CreateBiometricUserDtoX on CreateBiometricUserDto {
  CreateBiometricUser toEntity() => CreateBiometricUser(
      userNo: userNo ?? 0,
      userId: userId ?? "",
      firstName: firstName ?? "",
      middleName: middleName,
      lastName: lastName ?? "",
      email: email ?? "",
      phoneNo: phoneNo ?? "",
      customerId: customerId,
      dateOfBirth: dateOfBirth,
      address: address ?? "",
      city: city ?? "",
      state: state ?? "",
      country: country ?? "",
      postalCode: postalCode ?? "",
      profilePictureUrl: profilePictureUrl,
      domainId: domainId ?? "",
      createdAt: createdAt ?? "",
      updatedAt: updatedAt ?? "",
  );
}
