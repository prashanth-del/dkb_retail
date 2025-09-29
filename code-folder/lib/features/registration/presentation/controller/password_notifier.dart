import 'package:dkb_retail/features/registration/data/modals/password_validation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PasswordNotifier extends StateNotifier<PasswordValidation> {
  PasswordNotifier() : super(const PasswordValidation());

  void validate(String password) {
    final numbers = RegExp(r'[0-9]').allMatches(password).length;
    final specials = RegExp(
      r'[!@#$%^&*(),.?":{}|<>-]',
    ).allMatches(password).length;

    state = PasswordValidation(
      length: password.length,
      hasMinLength: password.length >= 8,
      hasUppercase: password.contains(RegExp(r'[A-Z]')),
      hasLowercase: password.contains(RegExp(r'[a-z]')),
      hasNumber: numbers >= 1,
      hasSpecialChar: specials >= 1,
      hasTwoNumbers: numbers >= 2,
      hasTwoSpecialChars: specials >= 2,
    );
  }
}

final validatePasswordProvider =
    StateNotifierProvider.autoDispose<PasswordNotifier, PasswordValidation>(
      (ref) => PasswordNotifier(),
    );
