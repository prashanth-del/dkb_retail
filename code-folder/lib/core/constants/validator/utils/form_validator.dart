import 'package:dkb_retail/core/constants/validator/utils/validators/customer_id_validator.dart';
import 'package:dkb_retail/core/constants/validator/utils/validators/email_validator.dart';
import 'package:dkb_retail/core/constants/validator/utils/validators/form_validator.dart';
import 'package:dkb_retail/core/constants/validator/utils/validators/full_name_validator.dart';
import 'package:dkb_retail/core/constants/validator/utils/validators/password_validator.dart';
import 'package:dkb_retail/core/constants/validator/utils/validators/qatar_mobile_validatior.dart';
import 'package:dkb_retail/core/constants/validator/utils/validators/user_name_validator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'form_validator.g.dart';

@riverpod
class FormValidatorNotifier extends _$FormValidatorNotifier {
  @override
  FormValidator build() {
    return _buildFormValidator(ref);
  }

  // Extracted method to build the FormValidator
  static FormValidator _buildFormValidator(Ref ref) {
    return FormValidator(
      usernameValidator: ref.watch(usernameValidator),
      emailValidator: ref.watch(emailValidator),
      customerIdValidator: ref.watch(customerValidator),
      passwordValidator: ref.watch(passwordValidator),
      fullNameValidator: ref.watch(fullNameValidator),
      qatarMobileNumberValidator: ref.watch(qatarMobileValidator),
    );
  }

  String? validateUsername(String? value) {
    return state.usernameValidation(value);
  }

  String? validateCustomerId(String? value) {
    return state.customerIdValidation(value);
  }

  String? validateEmail(String? value) {
    return state.emailValidation(value);
  }

  String? validatePassword(String? value) {
    return state.passwordValidation(value);
  }

  String? validateFullName(String? value) {
    return state.fullNameValidation(value);
  }

  String? qatarMobileNumber(String? value) {
    return state.qatarMobileNumberValidation(value);
  }
}
