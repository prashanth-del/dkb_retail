import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../i18n/controller/i18n_providers.dart';
import '../../../app_strings/default_string.dart';
import '../../errors/failures.dart';
import '../i_validator.dart';

class _QatarMobileValidatorEn implements IValidator {
  final Ref ref;
  _QatarMobileValidatorEn(this.ref);

  @override
  ValidationFailure? validate(String? value) {
    final _localization = ref.watch(appLocalizationProvider);

    // Rule 1: Mandatory check
    if (value == null || value.trim().isEmpty) {
      return ValidationFailure.invalidQatarMobileNumber(
        message: _localization.getString("MSG008").isEmpty
            ? DefaultString.instance.requiredFieldTitle
            : _localization.getString("MSG008"),
      );
    }

    // Remove country code if provided (assume country code is +974 and non-editable)
    String mobile = value.trim();
    if (mobile.startsWith("+974")) {
      mobile = mobile.substring(4).trim();
    }

    // Rule 2: Numeric check
    final numericRegex = RegExp(r'^[0-9]+$');
    if (!numericRegex.hasMatch(mobile)) {
      return ValidationFailure.invalidQatarMobileNumber(
        message: _localization.getString("Only_Numeric").isEmpty
            ? DefaultString.instance.onlyNumberValidate
            : _localization.getString("Only_Numeric"),
      );
    }

    // Rule 3: Length check
    if (mobile.length != 8) {
      return ValidationFailure.underLimitLength(
        message: _localization.getString("MSG007").isEmpty
            ? DefaultString.instance.mobileNumberValidate
            : _localization.getString("MSG007"),
      );
    }

    // Rule 4: Allowed starting digits
    final firstDigit = mobile[0];
    if (!["3", "5", "6", "7"].contains(firstDigit)) {
      return ValidationFailure.invalidQatarMobileNumber(
        message: _localization.getString("MSG006").isEmpty
            ? DefaultString.instance.qatarMobileValidate
            : _localization.getString("MSG006"),
      );
    }

    // ✅ Passed all checks
    return null;
  }
}

final qatarMobileValidator = Provider((ref) {
  return _QatarMobileValidatorEn(ref);
});
