import 'package:freezed_annotation/freezed_annotation.dart';


part 'otp_generate.freezed.dart';

@freezed
class OtpGenerate with _$OtpGenerate {
  const factory OtpGenerate({
    required String mobileNumber,
    required int rimNo,
    required String message,
  }) = _OtpGenerate;
}
