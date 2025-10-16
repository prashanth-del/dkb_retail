import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/otp_validate_entites/otp_validate.dart';

part 'validate_otp_state.freezed.dart';

@freezed
class ValidateOtpState with _$ValidateOtpState {
  const factory ValidateOtpState.initial() = _Initial;
  const factory ValidateOtpState.loading() = _Loading;
  const factory ValidateOtpState.success(OtpValidate? data) = _Success;
  const factory ValidateOtpState.failure(String message) = _Failure;
}
