import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:db_uicomponents/src/utils/device_info/src/device_model.dart';
import 'validate_username_request_request_info_dto.dart';

part 'validate_username_request.freezed.dart';
part 'validate_username_request.g.dart';

@freezed
class ValidateUsernameRequest with _$ValidateUsernameRequest {
  const factory ValidateUsernameRequest({
    ValidateUsernameRequestRequestInfoDto? requestInfo,
    @JsonKey(ignore: true) DeviceModel? deviceInfo,
  }) = _ValidateUsernameRequest;

  factory ValidateUsernameRequest.fromJson(Map<String, dynamic> json) =>
      _$ValidateUsernameRequestFromJson(json);
}
