import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../common/utils.dart';
import '../../../registration/domain/entities/card_validation_modal.dart';
import 'forgot_password_controller.dart';

//validator provider
final forgotPasswordValidatorProvider = Provider<ForgotPasswordValidators>((
  ref,
) {
  final binsJson = ref.watch(activeCardProvider);

  final activeBins = binsJson.map((e) => e.bin).toList();
  consoleLog("activeBin : $activeBins ");

  return ForgotPasswordValidators(binsJson: binsJson, activeBins: activeBins);
});

//validator

class ForgotPasswordValidators {
  final List<String> activeBins;
  final List<CardValidationModal> binsJson;

  ForgotPasswordValidators({required this.activeBins, required this.binsJson});

  String? validateCardNumber(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return "Card number is required";
    }
    final normalized = value.replaceAll(' ', '');

    // if (activeBins.isNotEmpty) {
    //   int maxLength = activeBins
    //       .map((e) => e.toString().length)
    //       .reduce((a, b) => a > b ? a : b);

    //   if (normalized.length > maxLength) {
    //     final firstSix = normalized.substring(0, maxLength);

    //     if (!activeBins.contains(firstSix)) {
    //       return "Invalid card";
    //     }
    //   }
    // }

    if (activeBins.isNotEmpty) {
      final normalizedValue = normalized.trim();

      final isValid = activeBins.any((bin) {
        final normalizedBin = bin.trim();
        // match if value starts with bin OR bin starts with value
        return normalizedValue.startsWith(normalizedBin) ||
            normalizedBin.startsWith(normalizedValue);
      });

      if (!isValid) {
        return "Invalid card";
      }
    }

    if (normalized.length != 16) {
      return "Card number must be 16 digits";
    }

    return null; // valid
  }

  String? validatePin(String? value) {
    if (value == null || value.isEmpty) {
      return "Pin is required";
    }

    if (value.trim().length < 4) {
      return 'Enter a valid Pin';
    }
    return null;
  }
}
