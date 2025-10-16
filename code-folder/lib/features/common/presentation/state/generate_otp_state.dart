import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/otp_generate_entities/otp_generate.dart';

part 'generate_otp_state.freezed.dart';

@freezed
class GenerateOtpState with _$GenerateOtpState {
  const factory GenerateOtpState.initial() = _Initial;
  const factory GenerateOtpState.loading() = _Loading;
  const factory GenerateOtpState.success(OtpGenerate? data) = _Success;
  const factory GenerateOtpState.failure(String message) = _Failure;
}
