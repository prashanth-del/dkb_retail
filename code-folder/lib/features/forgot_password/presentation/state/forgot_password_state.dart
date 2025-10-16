import 'package:dkb_retail/features/forgot_password/domain/entities/validate_card_entites/validate_card_response_data.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'forgot_password_state.freezed.dart';

@freezed
class ForgotPasswordState with _$ForgotPasswordState {
  const factory ForgotPasswordState.initial() = _Initial;
  const factory ForgotPasswordState.loading() = _Loading;
  const factory ForgotPasswordState.success(dynamic data) = _Success;
  const factory ForgotPasswordState.failure(String message) = _Failure;
  const factory ForgotPasswordState.checkCardNumber() = _CheckCardNumber;
  const factory ForgotPasswordState.otpResent() = _OtpResent;
  const factory ForgotPasswordState.otpValid() = _OtpValid;
  const factory ForgotPasswordState.maxAttempted() = _MaxAttempted;
  const factory ForgotPasswordState.cardValidated(
    ValidateCardResponseData data,
  ) = _CardValidated;
}
