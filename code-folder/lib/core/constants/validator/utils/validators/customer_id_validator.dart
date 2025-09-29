import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../i18n/controller/i18n_providers.dart';
import '../../errors/failures.dart';
import '../i_validator.dart';

class _CustomerIdValidator implements IValidator {
  final Ref ref;
  final RegExp numReg = RegExp(r"^[0-9]+$");
  _CustomerIdValidator(this.ref);

  @override
  ValidationFailure? validate(String? value) {

    final _localization = ref.watch(appLocalizationProvider);

    if (value == null) {
      return  ValidationFailure.empty(message: _localization.getString("enter_customer_no_here"));
    } else if (!numReg.hasMatch(value)) {
      return  ValidationFailure.empty(message: _localization.getString("Enter_Customer_Number"));
    }
    // else if (value.length > 7) {
    //   return  ValidationFailure.exceededLength(message: _localization.getString("Exceeded_30_Characters"));
    // }
    return null;
  }
}

final customerValidator = Provider((ref) {
  return _CustomerIdValidator(ref);
});