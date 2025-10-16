import 'package:freezed_annotation/freezed_annotation.dart';


part 'create_biometric_user.freezed.dart';

@freezed
class CreateBiometricUser with _$CreateBiometricUser {
  const factory CreateBiometricUser({
    required int userNo,
    required String userId,
    required String firstName,
    required dynamic middleName,
    required String lastName,
    required String email,
    required String phoneNo,
    required dynamic customerId,
    required dynamic dateOfBirth,
    required String address,
    required String city,
    required String state,
    required String country,
    required String postalCode,
    required dynamic profilePictureUrl,
    required String domainId,
    required String createdAt,
    required String updatedAt,
  }) = _CreateBiometricUser;
}
