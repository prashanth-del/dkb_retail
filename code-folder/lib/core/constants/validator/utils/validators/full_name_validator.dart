//full_name_validator
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../i18n/controller/i18n_providers.dart';
import '../../errors/failures.dart';
import '../i_validator.dart';

class _FullNameValidatorEn implements IValidator {
  final Ref ref;
  _FullNameValidatorEn(this.ref);

  @override
  ValidationFailure? validate(String? value) {
    final _localization = ref.watch(appLocalizationProvider);

    // Configurable maximum length
    const int maxLength = 50;

    // Profanity words list (can be extended or loaded externally)
    final profanityList = <String>["badword1", "badword2", "badword3"];

    // Rule 1: Mandatory check
    if (value == null || value.trim().isEmpty) {
      return ValidationFailure.empty(
        message: _localization.getString("MSG003").isEmpty
            ? "This field is required MSG003"
            : _localization.getString("MSG003"),
      );
    }

    final name = value.trim();

    // Rule 2 & 6: Only alphabets + spaces allowed
    final regex = RegExp(r'^[A-Za-z ]+$');
    if (!regex.hasMatch(name)) {
      return ValidationFailure.invalidFullName(
        message: _localization.getString("Only_Alphabets_Spaces").isEmpty
            ? "Only alphabets and spaces are allowed"
            : _localization.getString("Only_Alphabets_Spaces"),
      );
    }

    // Rule 3: Must contain at least two words
    final words = name
        .split(RegExp(r'\s+'))
        .where((w) => w.isNotEmpty)
        .toList();
    if (words.length < 2) {
      return ValidationFailure.invalidFullName(
        message: _localization.getString("MSG004").isEmpty
            ? "The name should consist of two words separated by a space"
            : _localization.getString("MSG004"),
      );
    }

    // Rule 4: Max length check
    if (name.length > maxLength) {
      return ValidationFailure.exceededLength(
        message: _localization.getString("Exceeded_Name_Length").isEmpty
            ? "Maximum length of $maxLength characters exceeded"
            : _localization.getString("Exceeded_Name_Length"),
      );
    }

    // Rule 5: Profanity check
    for (final badWord in profanityList) {
      if (name.toLowerCase().contains(badWord.toLowerCase())) {
        return ValidationFailure.invalidFullName(
          message: _localization.getString("Profanity_Not_Allowed").isEmpty
              ? "Inappropriate words are not allowed"
              : _localization.getString("Profanity_Not_Allowed"),
        );
      }
    }

    // ✅ Passed all checks
    return null;
  }
}

final fullNameValidator = Provider((ref) {
  return _FullNameValidatorEn(ref);
});
