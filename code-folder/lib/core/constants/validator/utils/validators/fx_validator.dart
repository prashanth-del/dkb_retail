import '../i_validator.dart';

class FxValidator {
  final IValidator fxCurrencyValidator;
  final IValidator fxNarrationValidator;
  final IValidator fxTenorValidator;
  final IValidator fxDateValidator;
  final IValidator fxAmountValidator;

  FxValidator({
    required this.fxCurrencyValidator,
    required this.fxNarrationValidator,
    required this.fxTenorValidator,
    required this.fxDateValidator,
    required this.fxAmountValidator,
  });

  String? Function(String?) get fxCurrencyValidaton => (String? value) {
    final failure = fxCurrencyValidator.validate(value);
    return failure?.map(
      empty: (f) => f.message,
      underLimitLength: (f) => null,
      exceededLength: (f) => f.message,
      invalidEmail: (f) => null,
      invalidPhone: (f) => null,
      invalidCustomerId: (f) => null,
      invalidFormat: (f) => null, // This won't be used for username
      invalidFullName: (f) => f.message,
      invalidQatarMobileNumber: (f) => f.message,
    );
  };

  String? Function(String?) get fxNarrationValidaton => (String? value) {
    final failure = fxNarrationValidator.validate(value);
    return failure?.map(
      empty: (f) => f.message,
      underLimitLength: (f) => null,
      exceededLength: (f) => f.message,
      invalidEmail: (f) => null,
      invalidPhone: (f) => null,
      invalidFormat: (f) => null, // This won't be used for username
      invalidCustomerId: (f) => f.message,
      invalidFullName: (f) => f.message,
      invalidQatarMobileNumber: (f) => f.message,
    );
  };

  String? Function(String?) get fxTenorValidaton => (String? value) {
    final failure = fxTenorValidator.validate(value);
    return failure?.map(
      invalidEmail: (f) => null,
      underLimitLength: (f) => f.message,
      empty: (f) => f.message,
      exceededLength: (f) => null,
      invalidPhone: (f) => null,
      invalidCustomerId: (f) => null,
      invalidFormat: (f) => null, // This won't be used for username
      invalidFullName: (f) => f.message,
      invalidQatarMobileNumber:(f) =>  f.message,
    );
  };

  String? Function(String?) get fxDateValidaton => (String? value) {
    final failure = fxDateValidator.validate(value);
    return failure?.map(
      empty: (f) => f.message,
      underLimitLength: (f) => null,
      exceededLength: (f) => f.message,
      invalidEmail: (f) => null,
      invalidPhone: (f) => null,
      invalidCustomerId: (f) => null,
      invalidFormat: (f) => null, // This won't be used for username
      invalidFullName: (f) => f.message,
      invalidQatarMobileNumber:(f) =>  f.message,
    );
  };

  String? Function(String?) get fxAmountValidaton => (String? value) {
    final failure = fxAmountValidator.validate(value);
    return failure?.map(
      empty: (f) => f.message,
      underLimitLength: (f) => null,
      exceededLength: (f) => f.message,
      invalidEmail: (f) => null,
      invalidPhone: (f) => null,
      invalidCustomerId: (f) => null,
      invalidFormat: (f) => null, // This won't be used for username
      invalidFullName: (f) => f.message,
      invalidQatarMobileNumber: (f) => f.message,
    );
  };
}
