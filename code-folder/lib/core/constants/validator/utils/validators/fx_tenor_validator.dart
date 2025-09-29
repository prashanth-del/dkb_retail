import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../i18n/controller/i18n_providers.dart';
import '../../errors/failures.dart';
import '../i_validator.dart';

class _FxTenorValidator implements IValidator {
  final Ref ref;
  final RegExp numReg = RegExp(r"^[a-zA-Z0-9]*$");
  _FxTenorValidator(this.ref);

  @override
  ValidationFailure? validate(String? value) {

    final _localization = ref.watch(appLocalizationProvider);

    if (value == null) {
      return  ValidationFailure.empty(message: "Enter the value");
    } else if ((double.tryParse(value) ?? 0)  > 1095 || (double.tryParse(value) ?? 0) < 7) {
      return  ValidationFailure.empty(message: _localization.getString("Please_enter_the_valid_tenor"));
    } else if (value.length > 50) {
      return  ValidationFailure.exceededLength(message: "Excceeded 50 character");
    }
    return null;
  }
}

final fxTenorValidator = Provider((ref) {
  return _FxTenorValidator(ref);
});