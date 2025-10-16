// GENERATED Entity (Freezed): ValidateCardRequestDeviceInfo
import 'package:freezed_annotation/freezed_annotation.dart';


part 'validate_card_request_device_info.freezed.dart';

@freezed
class ValidateCardRequestDeviceInfo with _$ValidateCardRequestDeviceInfo {
  const factory ValidateCardRequestDeviceInfo({
    required String deviceId,
    required String ipAddress,
    required String vendorId,
    required String osVersion,
    required String osType,
    required String appVersion,
    required String endToEndId,
  }) = _ValidateCardRequestDeviceInfo;
}
