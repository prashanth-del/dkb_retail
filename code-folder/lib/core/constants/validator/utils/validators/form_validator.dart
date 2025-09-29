import '../i_validator.dart';

class FormValidator {
  final IValidator usernameValidator;
  final IValidator emailValidator;
  final IValidator customerIdValidator;
  // final IValidator phoneValidator;
  final IValidator passwordValidator;
  final IValidator fullNameValidator;
  final IValidator qatarMobileNumberValidator;

  FormValidator({
    required this.usernameValidator,
    required this.emailValidator,
    required this.customerIdValidator,
    required this.fullNameValidator,
    required this.passwordValidator,
    required this.qatarMobileNumberValidator,
  });

  String? Function(String?) get usernameValidation => (String? value) {
    final failure = usernameValidator.validate(value);
    return failure?.map(
      empty: (f) => f.message,
      underLimitLength: (f) => f.message,
      exceededLength: (f) => f.message,
      invalidEmail: (f) => null, // This won't be used for username
      invalidPhone: (f) => null, // This won't be used for username
      invalidCustomerId: (f) => null,

      invalidFormat: (f) => null,
      invalidFullName: (f) => f.message, // This won't be used for username
      invalidQatarMobileNumber: (f) =>f.message,
      // This won't be used for username
    );
  };

  String? Function(String?) get customerIdValidation => (String? value) {
    final failure = customerIdValidator.validate(value);
    return failure?.map(
      empty: (f) => f.message,
      underLimitLength: (f) => f.message,
      exceededLength: (f) => f.message,
      invalidEmail: (f) => null, // This won't be used for username
      invalidPhone: (f) => null,
      invalidFormat: (f) => null, // This won't be used for username
      invalidCustomerId: (f) => f.message,
      invalidFullName: (f) => f.message,
      invalidQatarMobileNumber: (f) =>f.message,
    );
  };

  String? Function(String?) get emailValidation => (String? value) {
    final failure = emailValidator.validate(value);
    return failure?.map(
      invalidEmail: (f) => f.message,
      underLimitLength: (f) => f.message,
      empty: (f) => null, // This won't be used for email
      exceededLength: (f) => null, // This won't be used for email
      invalidPhone: (f) => null, // This won't be used for email
      invalidCustomerId: (f) => null, // This won't be used for email
      invalidFormat: (f) => null,
      invalidFullName: (f) => f.message,
      invalidQatarMobileNumber:(f) => f.message,
    );
  };

  // String? Function(String?) get phoneValidation => (String? value) {
  //   final failure = phoneValidator.validate(value);
  //   return failure?.map(
  //     invalidPhone: (f) => f.message,
  //     empty: (f) => null, // This won't be used for phone
  //     exceededLength: (f) => null, // This won't be used for phone
  //     invalidEmail: (f) => null, // This won't be used for phone
  //     invalidNationalId: (f) => null, // This won't be used for phone
  //   );
  // };

  String? Function(String?) get passwordValidation => (String? value) {
    final failure = passwordValidator.validate(value);
    return failure?.map(
      empty: (f) => f.message,
      underLimitLength: (f) => f.message,
      exceededLength: (f) => f.message,
      invalidEmail: (f) => null, // This won't be used for password
      invalidPhone: (f) => null, // This won't be used for password
      invalidCustomerId: (f) => null,
      invalidFormat: (f) => null,
      invalidFullName: (f) => f.message,
      invalidQatarMobileNumber:(f) => f.message,
      // This won't be used for password
    );
  };

  String? Function(String?) get fullNameValidation => (String? value) {
    final failure = fullNameValidator.validate(value);
    return failure?.map(
      invalidEmail: (f) => f.message,
      underLimitLength: (f) => f.message,
      empty: (f) => null, // This won't be used for email
      exceededLength: (f) => null, // This won't be used for email
      invalidPhone: (f) => null, // This won't be used for email
      invalidCustomerId: (f) => null, // This won't be used for email
      invalidFormat: (f) => null,
      invalidFullName: (f) => f.message,
      invalidQatarMobileNumber:(f) => f.message,
    );
  };

  String? Function(String?) get qatarMobileNumberValidation => (String? value) {
    final failure = qatarMobileNumberValidator.validate(value);
    return failure?.map(
      invalidEmail: (f) => f.message,
      underLimitLength: (f) => f.message,
      empty: (f) => null, // This won't be used for email
      exceededLength: (f) => null, // This won't be used for email
      invalidPhone: (f) => null, // This won't be used for email
      invalidCustomerId: (f) => null, // This won't be used for email
      invalidFormat: (f) => null,
      invalidFullName: (f) => f.message,
      invalidQatarMobileNumber:(f) => f.message,
    );
  };
}
