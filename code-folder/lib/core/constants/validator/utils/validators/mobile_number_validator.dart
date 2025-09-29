import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../errors/failures.dart';
import '../i_validator.dart';

class _MobileNumberValidator implements IValidator {
  final Ref ref;
  // final RegExp numReg = RegExp(r"^[0-9,.]*$");
  final RegExp numReg = RegExp(r"^[0-9]{8}$"); // Matches exactly 8 numeric digits
  final RegExp validStartReg = RegExp(r"^[3567]"); // Valid starting digits for Qatar numbers


  _MobileNumberValidator(this.ref);

  @override
  ValidationFailure? validate(String? value) {


    if (value == null || value.isEmpty) {
      return  const ValidationFailure.empty(message: "This field is required.");
    } else if (!numReg.hasMatch(value)) {
      return  const ValidationFailure.exceededLength(message: "Mobile number should be of 8 characters.");
    } else  if (!validStartReg.hasMatch(value)) {
      // Rule 7: Invalid starting digit
      return const ValidationFailure.invalidFormat(
          message: "Mobile number should start with 3, 5, 6, or 7.");
    }


    return null;
  }
}

final mobileNumberValidator = Provider((ref) {
  return _MobileNumberValidator(ref);
});

