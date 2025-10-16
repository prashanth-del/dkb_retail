import 'package:dkb_retail/common/utils.dart';
import 'package:dkb_retail/features/registration/domain/entities/card_validation_modal.dart';
import 'package:dkb_retail/features/registration/presentation/controller/registration_notifiers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final binsJsonProvider = Provider<List<CardValidationModal>>((ref) {
  final data = ref.watch(registrationNotifierProvider);

  return data.when(
    data: (data) {
      consoleLog('data************ $data');
      return data as List<CardValidationModal>;
    },
    loading: () => [],
    error: (e, st) {
      consoleLog('error************ $e');
      return [];
    },
  );
});

final regCardValidatorProvider = Provider<RegCardValidator>((ref) {
  final binsJson = ref.watch(binsJsonProvider);
  consoleLog("inside controller list $binsJson ");

  // Extract all active BINs
  final activeBins = binsJson.map((e) => e.bin).toList();
  consoleLog("activeBin : $activeBins ");

  return RegCardValidator(activeBins: activeBins, binsJson: binsJson);
});

class RegCardValidator {
  final List<String> activeBins;
  final List<CardValidationModal> binsJson;

  RegCardValidator({required this.activeBins, required this.binsJson});

  String? validate(String? value) {
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
      final binLengths = activeBins.map((e) => e.toString().length).toSet();
      bool isValid = false;

      for (final length in binLengths) {
        if (normalized.length >= length) {
          final prefix = normalized.substring(0, length);
          if (activeBins.contains(prefix)) {
            isValid = true;
            break;
          }
        }
      }

      if (!isValid) {
        return "Invalid card";
      }
    }

    if (normalized.length != 16) {
      return "Card number must be 16 digits";
    }
    return null; // valid
  }

  CardValidationModal? getCardDetails(String cardNumber) {
    if (cardNumber.length < 6) return null;
    final bin = cardNumber.substring(0, 6);

    return binsJson.firstWhere(
      (e) => e.bin == bin && e.status == "ACTIVE",
      orElse: () {
        return CardValidationModal(
          code: '',
          bin: "",
          productType: "",
          cardType: "",
          status: "",
        );
      },
    );
  }
}
