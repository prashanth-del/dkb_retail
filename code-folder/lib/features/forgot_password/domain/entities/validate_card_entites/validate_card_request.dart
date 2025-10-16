// GENERATED Entity (Freezed): ValidateCardRequest
import 'package:freezed_annotation/freezed_annotation.dart';
import 'validate_card_request_request_info.dart';
import 'validate_card_request_device_info.dart';

part 'validate_card_request.freezed.dart';

@freezed
class ValidateCardRequest with _$ValidateCardRequest {
  const factory ValidateCardRequest({
    ValidateCardRequestRequestInfo? requestInfo,
    ValidateCardRequestDeviceInfo? deviceInfo,
  }) = _ValidateCardRequest;
}
