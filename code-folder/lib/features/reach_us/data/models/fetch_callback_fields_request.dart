import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:db_uicomponents/src/utils/device_info/src/device_model.dart';


part 'fetch_callback_fields_request.freezed.dart';
part 'fetch_callback_fields_request.g.dart';

@freezed
class FetchCallbackFieldsRequest with _$FetchCallbackFieldsRequest {
  const factory FetchCallbackFieldsRequest({

    @JsonKey(ignore: true) DeviceModel? deviceInfo,
  }) = _FetchCallbackFieldsRequest;

  factory FetchCallbackFieldsRequest.fromJson(Map<String, dynamic> json) => _$FetchCallbackFieldsRequestFromJson(json);
}
