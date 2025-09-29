import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../i18n/controller/i18n_providers.dart';
import '../../errors/failures.dart';
import '../i_validator.dart';

class _FxDateValidator implements IValidator {
  final Ref ref;
  final RegExp numReg = RegExp(r"^[0-9/-]+$");
  _FxDateValidator(this.ref);

  @override
  ValidationFailure? validate(String? value) {

    final _localization = ref.watch(appLocalizationProvider);

    if (value == null) {
      return  ValidationFailure.empty(message: "Enter the value");
    } else if (!numReg.hasMatch(value)) {
      return  ValidationFailure.empty(message: "Enter correct type");
    }
    return null;
  }
}

final fxDateValidator = Provider((ref) {
  return _FxDateValidator(ref);
});