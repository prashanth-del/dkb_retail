import 'package:freezed_annotation/freezed_annotation.dart';

part 'forgot_password_failure.freezed.dart';

@freezed
sealed class ForgotPasswordFailure with _$ForgotPasswordFailure {
  const factory ForgotPasswordFailure.serviceFailure(String message) =
      ServiceFailure;
  const factory ForgotPasswordFailure.serverFailure(String message) =
      ServerFailure;
  const factory ForgotPasswordFailure.internetFailure(String message) =
      InternetFailure;
  const factory ForgotPasswordFailure.invalidOtp(String message) = InvalidOtp;
  const factory ForgotPasswordFailure.maxOtpAttempted(String message) =
      MaxOtpAttempted;
}
