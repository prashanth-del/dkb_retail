import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../errors/failures.dart';
import '../i_validator.dart';

class _EmailValidator implements IValidator {
  final Ref ref;
  _EmailValidator(this.ref);

  // Configurable length
  final int minLength = 5;
  final int maxLength = 50;

  // Allowed special characters
  final RegExp _allowedChars = RegExp(r'^[a-zA-Z0-9@._-]+$');

  // Email must end with .com
  final RegExp _emailPattern = RegExp(r'^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.com$');

  // Example profanity list
  final List<String> _profanityList = ["badword1", "badword2", "testprofanity"];

  @override
  ValidationFailure? validate(String? value) {
    if (value == null || value.isEmpty) {
      // Optional field → no error if empty
      return null;
    }

    // Length check
    if (value.length < minLength || value.length > maxLength) {
      return const ValidationFailure.invalidEmail(
        message: "Please enter valid email. MSG005",
      );
    }

    // Profanity check
    for (final word in _profanityList) {
      if (value.toLowerCase().contains(word)) {
        return const ValidationFailure.invalidEmail(
          message: "Please enter valid email.",
        );
      }
    }

    // Allowed characters only
    if (!_allowedChars.hasMatch(value)) {
      return const ValidationFailure.invalidEmail(
        message: "Please enter valid email.",
      );
    }

    // Must contain @ and end with .com
    if (!_emailPattern.hasMatch(value)) {
      return const ValidationFailure.invalidEmail(
        message: "Please enter valid email.",
      );
    }

    return null; // ✅ valid
  }
}

final emailValidator = Provider((ref) {
  return _EmailValidator(ref);
});
//////////////////////////////old_validation//////////////////////////////////
// class _EmailValidator implements IValidator {
//
//   final Ref ref;
//   _EmailValidator(this.ref);
//
//   final RegExp _regEx = RegExp(
//     r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?",
//   );
//
//   @override
//   ValidationFailure? validate(String? value) {
//     if (value == null || !_regEx.hasMatch(value)) {
//       return const ValidationFailure.invalidEmail(message: 'Enter a valid email address');
//     }
//     return null;
//   }
// }
//
// final emailValidator = Provider((ref) {
//     return _EmailValidator(ref);
// });
