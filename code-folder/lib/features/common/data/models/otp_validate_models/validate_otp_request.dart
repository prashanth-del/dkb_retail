import 'package:dkb_retail/features/common/data/models/otp_validate_models/validate_otp_request_request_info_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:db_uicomponents/src/utils/device_info/src/device_model.dart';

part 'validate_otp_request.freezed.dart';
part 'validate_otp_request.g.dart';

@freezed
class ValidateOtpRequest with _$ValidateOtpRequest {
  const factory ValidateOtpRequest({
    ValidateOtpRequestRequestInfoDto? requestInfo,
    @JsonKey(ignore: true) DeviceModel? deviceInfo,
  }) = _ValidateOtpRequest;

  factory ValidateOtpRequest.fromJson(Map<String, dynamic> json) => _$ValidateOtpRequestFromJson(json);
}
