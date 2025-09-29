// --- Providers ---
import 'package:dkb_retail/features/registration/data/modals/password_validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final cardNumberControllerProvider =
    Provider.autoDispose<TextEditingController>(
      (ref) => TextEditingController(),
    );

final pinNumberControllerProvider = Provider.autoDispose<TextEditingController>(
  (ref) => TextEditingController(),
);
final qidpassportTextProvider = StateProvider.autoDispose<String>((ref) => '');
final userMobileTextProvider = StateProvider.autoDispose<String>((ref) => '');

final qidpassportProvider = Provider.autoDispose<TextEditingController>((ref) {
  final controller = TextEditingController();

  // keep text in sync

  controller.addListener(() {
    ref.read(qidpassportTextProvider.notifier).state = controller.text;
  });

  ref.onDispose(() => controller.dispose());
  return controller;
});

final userMobileProvider = Provider.autoDispose<TextEditingController>((ref) {
  final controller = TextEditingController();

  controller.addListener(() {
    ref.read(userMobileTextProvider.notifier).state = controller.text;
  });

  ref.onDispose(() => controller.dispose());
  return controller;
});

final isqidFormValidProvider = Provider.autoDispose<bool>((ref) {
  final mobile = ref.watch(userMobileTextProvider).trim();
  final name = ref.watch(qidpassportTextProvider).trim();

  final isMobileValid = qatarMobileValidator(mobile) == null;
  final isNameValid = requiredTextValidator(name) == null;

  return isMobileValid && isNameValid;
});

final cardFocusNodeProvider = Provider<FocusNode>((ref) => FocusNode());
final pinFocusNodeProvider = Provider<FocusNode>((ref) => FocusNode());

final isVisibleProvider = StateProvider.autoDispose<bool>((ref) => false);
final isCardValidProvider = StateProvider.autoDispose<bool>((ref) => false);
final isCVVVisibleProvider = StateProvider.autoDispose<bool>((ref) => false);
final canResendOtpController = StateProvider.autoDispose<bool>((ref) => false);
final otpController = StateProvider<String>((ref) => '');

final passwordTextProvider = StateProvider<String>((ref) => '');

// Toggles
final showPasswordProvider = StateProvider.autoDispose<bool>((ref) => false);
final passwordControllerProvider = StateProvider.autoDispose<String>(
  (ref) => "",
);
final confirmPasswordControllerProvider = StateProvider.autoDispose<String>(
  (ref) => "",
);

final issetPasswordVisible = StateProvider.autoDispose<bool>((ref) => false);
final issetConfirmPasswordVisible = StateProvider.autoDispose<bool>(
  (ref) => false,
);

final pinProvider = StateProvider.autoDispose<String>((ref) => "");
final pinVisibleProvider = StateProvider.autoDispose<bool>((ref) => false);
final confirmPINProvider = StateProvider.autoDispose<String>((ref) => "");

final confirmpinVisibleProvider = StateProvider.autoDispose<bool>(
  (ref) => false,
);

final isConfirmPasswordProvider = Provider.autoDispose<bool>((ref) {
  final password = ref.watch(passwordControllerProvider);
  final confirmPassword = ref.watch(confirmPasswordControllerProvider);
  return password == confirmPassword && password.isNotEmpty;
});
final isConfirmPINProvider = Provider.autoDispose<bool>((ref) {
  final password = ref.watch(pinProvider);
  final confirmPassword = ref.watch(confirmPINProvider);
  return password == confirmPassword && password.isNotEmpty;
});
// final showConfirmPasswordProvider = StateProvider<bool>((ref) => false);
final passwordValidationProvider =
    StateProvider.autoDispose<PasswordValidation>((ref) {
      return const PasswordValidation(
        hasMinLength: false,
        hasUppercase: false,
        hasLowercase: false,
        hasNumber: false,
        hasSpecialChar: false,
      );
    });
String? qatarMobileValidator(String? value) {
  // 1. Field left blank
  if (value == null || value.trim().isEmpty) {
    return "This field is required";
  }

  final number = value.trim();

  if (!RegExp(r'^[0-9]+$').hasMatch(number)) {
    return "Mobile number must be numeric";
  }

  if (number.length != 8) {
    return "Mobile number should be of 8 digits";
  }

  final firstDigit = number[0];
  if (!["3", "5", "6", "7"].contains(firstDigit)) {
    return "Mobile number should start only with 3, 5, 6 and 7.";
  }

  return null;
}

String? requiredTextValidator(String? value) {
  final input = value?.trim() ?? "";

  if (input.isEmpty) {
    return "This field is required";
  }

  if (!RegExp(r'^[a-zA-Z0-9 ]+$').hasMatch(input)) {
    return "Special characters are not allowed";
  }

  return null;
}
