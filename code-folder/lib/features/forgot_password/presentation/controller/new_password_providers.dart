import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dkb_retail/features/registration/data/modals/password_validation.dart';

// Main password text
final passwordControllerProvider = StateProvider<String>((ref) => "");

// Confirm password text
final confirmPasswordControllerProvider = StateProvider<String>((ref) => "");

//Main Password visibility
final passwordVisibilityProvider = StateProvider<bool>((ref) => true);

// Validation rules
final validatePasswordProvider =
    StateNotifierProvider.autoDispose<
      PasswordValidationNotifier,
      PasswordValidation
    >((ref) => PasswordValidationNotifier());

// Match check
final isConfirmPasswordProvider = Provider<bool>((ref) {
  final pass = ref.watch(passwordControllerProvider);
  final confirm = ref.watch(confirmPasswordControllerProvider);
  return pass.isNotEmpty && pass == confirm;
});

class PasswordValidationNotifier extends StateNotifier<PasswordValidation> {
  PasswordValidationNotifier()
    : super(
        PasswordValidation(
          hasMinLength: false,
          hasUppercase: false,
          hasLowercase: false,
          hasNumber: false,
          hasSpecialChar: false,
        ),
      );

  void validate(String password) {
    state = PasswordValidation(
      hasMinLength: password.length >= 8 && password.length <= 32,
      hasUppercase: password.contains(RegExp(r'[A-Z]')),
      hasLowercase: password.contains(RegExp(r'[a-z]')),
      hasNumber: password.contains(RegExp(r'[0-9]')),
      hasSpecialChar: password.contains(RegExp(r'[!@#\$%\^&\*\-_\.]')),
    );
  }
}
