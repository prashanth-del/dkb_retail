import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../i18n/controller/i18n_providers.dart';
import '../../errors/failures.dart';
import '../i_validator.dart';

class _UserNameValidator implements IValidator {
  final Ref ref;

  _UserNameValidator(this.ref);

  @override
  ValidationFailure? validate(String? value) {
    final _localization = ref.watch(appLocalizationProvider);
    if (value == null || value.isEmpty) {
      return ValidationFailure.empty(
          message: _localization.getString('Enter_Username').isEmpty ? 'Enter Username' : _localization.getString('Enter_Username'));
    } else if (value.length < 8) {
      return ValidationFailure.underLimitLength(
          message: _localization.getString("Cant_have_less_than_8_characters").isEmpty ? 'Please Input Atleast 5 Characters' : _localization.getString("Cant_have_less_than_8_characters"));
    } else if (value.length > 12) {
      return ValidationFailure.exceededLength(
          message: _localization.getString("Exceeded_30_Characters_Username").isEmpty ? 'Please enter a valid Username' : _localization.getString("Exceeded_30_Characters_Username"));
    }
    return null;
  }
}

final usernameValidator = Provider((ref) {
  return _UserNameValidator(ref);
});
