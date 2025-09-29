// import 'package:dkb_retail/core/constants/validator/utils/validators/email_form_validator.dart';
// import 'package:dkb_retail/core/constants/validator/utils/validators/email_validator.dart';
//
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:riverpod_annotation/riverpod_annotation.dart';
//
// part 'email_form_validator.g.dart';
//
// @riverpod
// class EmailFormValidatorNotifier extends _$EmailFormValidatorNotifier {
//   @override
//   EmailFormValidator build() {
//     return _buildEmailFormValidator(ref);
//   }
//
//   // Extracted method to build the FormValidator
//   static EmailFormValidator _buildEmailFormValidator(Ref ref) {
//     return EmailFormValidator(
//       emailValidator: ref.watch(emailValidator),
//     );
//   }
//
//   String? validateEmail(String? value) {
//     return state.emailValidation(value);
//   }
//
//
// }
