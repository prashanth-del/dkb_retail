import 'package:freezed_annotation/freezed_annotation.dart';

part 'failures.freezed.dart';

@freezed
class ValidationFailure with _$ValidationFailure {
  const factory ValidationFailure.empty({required String message}) = Empty;
  const factory ValidationFailure.underLimitLength({required String message}) =
      UnderLimitLength;
  const factory ValidationFailure.exceededLength({required String message}) =
      ExceededLength;
  const factory ValidationFailure.invalidEmail({required String message}) =
      InvalidEmail;
  const factory ValidationFailure.invalidPhone({required String message}) =
      InvalidPhone;
  const factory ValidationFailure.invalidCustomerId({required String message}) =
      InvalidCustomerId;
  const factory ValidationFailure.invalidFormat({required String message}) =
      InvalidFormat;

  const factory ValidationFailure.invalidFullName({required String message}) =
      InvalidFullName;

  const factory ValidationFailure.invalidQatarMobileNumber({
    required String message,
  }) = InvalidQatarMobileNumber;
}
