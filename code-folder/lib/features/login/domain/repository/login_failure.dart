import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_failure.freezed.dart';

@freezed
sealed class LoginFailure with _$LoginFailure {
  const factory LoginFailure.serviceFailure(String message) = ServiceFailure;
  const factory LoginFailure.serverFailure(String message) = ServerFailure;
  const factory LoginFailure.internetFailure(String message) = InternetFailure;
  const factory LoginFailure.invalidOtp(String message) = InvalidOtp;
  const factory LoginFailure.maxOtpAttempted(String message) = MaxOtpAttempted;
}
