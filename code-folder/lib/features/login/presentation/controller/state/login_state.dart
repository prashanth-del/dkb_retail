import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../network/domain/models/auth_tokens.dart';
import '../../../domain/entities/user.dart';

part 'login_state.freezed.dart';

@freezed
class LoginState with _$LoginState {
  const factory LoginState.initial() = _Initial;
  const factory LoginState.loading() = _Loading;
  const factory LoginState.success(User user) = _Success;
  const factory LoginState.authenticated(AuthTokens tokens) = _Authenticated;
  const factory LoginState.failure(String message) = _Failure;
  const factory LoginState.otpResent() = _OtpResent;
  const factory LoginState.otpValid() = _OtpValid;
  const factory LoginState.maxAttempted(String message) = _MaxAttempted;
  const factory LoginState.passwordReset() = _PasswordReset;
  const factory LoginState.changePasswordFailure(String message) = _ChangePasswordFailure;

  const factory LoginState.logout() = _Logout;
}
