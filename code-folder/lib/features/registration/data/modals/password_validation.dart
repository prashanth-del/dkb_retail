// class PasswordValidation {
//   final bool hasMinLength;
//   final bool hasUppercase;
//   final bool hasLowercase;
//   final bool hasNumber;
//   final bool hasSpecialChar;

//   const PasswordValidation({
//     this.hasMinLength = false,
//     this.hasUppercase = false,
//     this.hasLowercase = false,
//     this.hasNumber = false,
//     this.hasSpecialChar = false,
//   });

//   bool get isValid =>
//       hasMinLength &&
//       hasUppercase &&
//       hasLowercase &&
//       hasNumber &&
//       hasSpecialChar;
// }

import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'password_validation.freezed.dart';

@freezed
class PasswordValidation with _$PasswordValidation {
  const factory PasswordValidation({
    @Default(false) bool hasMinLength,
    @Default(false) bool hasUppercase,
    @Default(false) bool hasLowercase,
    @Default(false) bool hasNumber,
    @Default(false) bool hasSpecialChar,
    @Default(false) bool hasTwoNumbers,
    @Default(false) bool hasTwoSpecialChars,
    @Default(0) int length,
  }) = _PasswordValidation;

  const PasswordValidation._();

  /// ✅ Overall strong condition
  bool get isStrong =>
      length > 9 &&
      hasUppercase &&
      hasLowercase &&
      hasTwoNumbers &&
      hasTwoSpecialChars;

  /// ✅ Progress value
  double get progress {
    final total = [
      hasMinLength,
      hasUppercase,
      hasLowercase,
      hasNumber,
      hasSpecialChar,
      hasTwoNumbers,
      hasTwoSpecialChars,
    ].where((e) => e).length;
    return total / 7;
  }

  /// ✅ Strength text
  String get strengthText {
    if (length < 8) return "Weak";
    if (isStrong) return "Strong";
    return "Medium";
  }

  /// ✅ Strength color
  Color get strengthColor {
    if (length < 8) return Colors.red;
    if (isStrong) return Colors.green;
    return Colors.orange;
  }
}
