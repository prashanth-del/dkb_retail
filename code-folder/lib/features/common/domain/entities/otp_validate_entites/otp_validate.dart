import 'package:freezed_annotation/freezed_annotation.dart';


part 'otp_validate.freezed.dart';

@freezed
class OtpValidate with _$OtpValidate {
  const factory OtpValidate({
    required String message,
  }) = _OtpValidate;
}
