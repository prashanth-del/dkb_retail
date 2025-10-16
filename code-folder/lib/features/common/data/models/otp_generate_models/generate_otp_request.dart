import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:db_uicomponents/src/utils/device_info/src/device_model.dart';
import 'generate_otp_request_request_info_dto.dart';

part 'generate_otp_request.freezed.dart';
part 'generate_otp_request.g.dart';

@freezed
class GenerateOtpRequest with _$GenerateOtpRequest {
  const factory GenerateOtpRequest({
    GenerateOtpRequestRequestInfoDto? requestInfo,
    @JsonKey(ignore: true) DeviceModel? deviceInfo,
  }) = _GenerateOtpRequest;

  factory GenerateOtpRequest.fromJson(Map<String, dynamic> json) => _$GenerateOtpRequestFromJson(json);
}
