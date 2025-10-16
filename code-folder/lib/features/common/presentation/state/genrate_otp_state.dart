import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/otp_generate_entities/otp_generate.dart';

part 'genrate_otp_state.freezed.dart';

@freezed
class GenrateOtpState with _$GenrateOtpState {
  const factory GenrateOtpState.initial() = _Initial;
  const factory GenrateOtpState.loading() = _Loading;
  const factory GenrateOtpState.success(List<OtpGenerate> data) = _Success;
  const factory GenrateOtpState.failure(String message) = _Failure;
}
