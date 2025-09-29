import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/user.dart';

part 'user_dto.freezed.dart';
part 'user_dto.g.dart';

@freezed
class UserDto with _$UserDto {
  const UserDto._();

  const factory UserDto({
    required String? atkn,
    required String? reftkn,
    required String? customerNumber,
    required String? branchCode,
    required String? firstLogin,
    required String? accessDate,
    required String? custinfoFlag,
    required String? preferredLang,
    required String? preferredUnits,
    required String? registeredUnit,
    required String? isOtpRequired,
    required String? username,
    required String? customerSegment,
    required String? customerType,
    required String? far,
    required String? userNo,
    required String? userId,
    required String? customerId,
    required String? emailId,
    required String? otpRefNo,
    required String? otpLength,
    required String? maskedMobileNo,
    required String? userRole,
    required String? dcUserName,
  }) = _UserDto;

  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);

  User toDomain() => User(
        atkn: atkn,
        reftkn: reftkn,
        customerNumber: customerNumber,
        branchCode: branchCode,
        firstLogin: (firstLogin != null && (firstLogin!.toLowerCase() == "0"))
            ? true
            : false,
        accessDate: accessDate,
      // isOtpRequired:
      //       (isOtpRequired != null && (isOtpRequired!.toLowerCase() == "y"))
      //           ? true
      //           : false,
    isOtpRequired: isOtpRequired,
        preferredLang: preferredLang,
        preferredUnits: preferredUnits,
        registeredUnit: registeredUnit,
      custinfoFlag: custinfoFlag,
        username: username,
        customerSegment: customerSegment,
        customerType: customerType,
        far: far,
        userNo: userNo,
        userId: userId,
        customerId: customerId,
        emailId: emailId,
        otpRefNo: otpRefNo,

      otpLength: int.parse(otpLength?.isEmpty ?? true ? '6' : otpLength!),
        maskedMobileNo: maskedMobileNo,
    userRole: userRole,
    dcUserName: dcUserName,
      );


}
