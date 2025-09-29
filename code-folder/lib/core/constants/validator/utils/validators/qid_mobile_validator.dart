import '../i_validator.dart';

class QidMobileValidator {
  final IValidator qidValidator;
  final IValidator mobileNumberValidator;

  QidMobileValidator({
    required this.qidValidator,
    required this.mobileNumberValidator,
  });

  String? Function(String?) get qidValidation => (String? value) {
    final failure = qidValidator.validate(value);
    return failure?.map(
      empty: (f) => f.message,
      underLimitLength: (f) => null,
      exceededLength: (f) => f.message,
      invalidEmail: (f) => null,
      invalidPhone: (f) => null,
      invalidCustomerId: (f) => null,
      invalidFormat: (f) => f.message, // This won't be used for username
      invalidFullName: (f) => f.message,
      invalidQatarMobileNumber: (f) => f.message,
    );
  };

  String? Function(String?) get mobileNumberValidation => (String? value) {
    final failure = mobileNumberValidator.validate(value);
    return failure?.map(
      empty: (f) => f.message,
      underLimitLength: (f) => null,
      exceededLength: (f) => f.message,
      invalidEmail: (f) => null,
      invalidPhone: (f) => null,
      invalidFormat: (f) => f.message, // This won't be used for username
      invalidCustomerId: (f) => null,
      invalidFullName: (f) => f.message,
      invalidQatarMobileNumber: (f) => f.message,
    );
  };
}
