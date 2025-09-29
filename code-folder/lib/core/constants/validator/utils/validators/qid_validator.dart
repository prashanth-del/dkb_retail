import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../errors/failures.dart';
import '../i_validator.dart';

class _QidValidator implements IValidator {
  final Ref ref;
  final RegExp numReg = RegExp(r"^[0-9,.]*$");
  _QidValidator(this.ref);

  @override
  ValidationFailure? validate(String? value) {


    if (value == null || value.isEmpty){
      return  ValidationFailure.empty(message: "This field is required.");
    } else if (value.length > 11 || value.length < 11) {
      return  ValidationFailure.exceededLength(message: "QID should be of 11 characters");
    }
    return null;
  }
}

final qidValidator = Provider((ref) {
  return _QidValidator(ref);
});