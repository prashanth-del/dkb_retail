import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../i18n/controller/i18n_providers.dart';
import '../../../../i18n/localization.dart';
import '../../errors/failures.dart';
import '../i_validator.dart';

class _PasswordValidatorEn implements IValidator {
  final Ref ref;
  _PasswordValidatorEn(this.ref);
  @override
  ValidationFailure? validate(String? value) {
    final _localization = ref.watch(appLocalizationProvider);
    if (value == null || value.isEmpty) {
      return ValidationFailure.empty(
          message: _localization.getString("Enter_Password").isEmpty ? 'Enter Password' : _localization.getString("Enter_Password"));
    }
    // else if (value.isEmpty) {
    //   return  ValidationFailure.underLimitLength(message: _localization.getString("Cant_have_less_than_8_characters"));
    // }
    // else if (value.length > 12) {
    //   return  ValidationFailure.exceededLength(message: _localization.getString("Exceeded_30_Characters_Password"));
    // }
    return null;
  }
}

final passwordValidator = Provider((ref) {
  return _PasswordValidatorEn(ref);
});
