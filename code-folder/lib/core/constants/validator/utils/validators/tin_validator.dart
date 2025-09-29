import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../errors/failures.dart';
import '../i_validator.dart';

class _TinValidator implements IValidator {
  final Ref ref;
  final RegExp regex = RegExp(r'^[A-Z0-9 ]+$');

  _TinValidator(this.ref);

  @override
  ValidationFailure? validate(String? value) {

    if (value == null || value.isEmpty) {
      return const ValidationFailure.empty(message: 'This field is required.');
    }
    if (!regex.hasMatch(value)) {
      return const ValidationFailure.invalidFormat(message: "Only uppercase alphanumeric characters and spaces are allowed.");
    }
    if (value.length != 19) {
      return const ValidationFailure.exceededLength(message: "TIN must be exactly 19 characters.");
    }
    return null;
  }
}

final tinValidator = Provider((ref) {
  return _TinValidator(ref);
});