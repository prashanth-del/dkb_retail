import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../i18n/controller/i18n_providers.dart';
import '../../errors/failures.dart';
import '../i_validator.dart';

class _FxCurrencyValidator implements IValidator {
  final Ref ref;
  final RegExp numReg = RegExp(r"^[a-zA-Z -]*$");
  _FxCurrencyValidator(this.ref);

  @override
  ValidationFailure? validate(String? value) {

    final _localization = ref.watch(appLocalizationProvider);

    if (value == null) {
      return  ValidationFailure.empty(message: "Enter the value");
    } else if (!numReg.hasMatch(value)) {
      return  ValidationFailure.empty(message: "Enter correct type");
    } else if (value.length > 50) {
      return  ValidationFailure.exceededLength(message: "Excceeded 50 character");
    }
    return null;
  }
}

final fxCurrencyValidator = Provider((ref) {
  return _FxCurrencyValidator(ref);
});