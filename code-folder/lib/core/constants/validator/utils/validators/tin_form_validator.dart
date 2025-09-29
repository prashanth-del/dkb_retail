import '../i_validator.dart';

class TinFormValidator {
  final IValidator tinValidator;

  TinFormValidator({required this.tinValidator});

  String? Function(String?) get tinValidation => (String? value) {
    final failure = tinValidator.validate(value);
    return failure?.map(
      empty: (f) => f.message,
      underLimitLength: (f) => null,
      exceededLength: (f) => f.message,
      invalidEmail: (f) => null,
      invalidPhone: (f) => null,
      invalidCustomerId: (f) => null,
      invalidFormat: (f) => f.message, // This won't be used for username
      invalidFullName: (f) => f.message,
      invalidQatarMobileNumber:(f) =>  f.message,
    );
  };
}
