import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';

@freezed
class User with _$User {
  factory User({
    required String? atkn,
    required String? reftkn,
    required String? customerNumber,
    required String? branchCode,
    required bool? firstLogin,
    required String? accessDate,
    required String? custinfoFlag,
    required String? preferredLang,
    required String? preferredUnits,
    required String? registeredUnit,
    // required bool? isOtpRequired,
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
    required int otpLength,
    required String? maskedMobileNo,
    required String? dcUserName,
    required String? userRole
  }) = _User;
}
