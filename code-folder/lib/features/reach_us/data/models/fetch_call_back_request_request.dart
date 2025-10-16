import 'package:db_uicomponents/src/utils/device_info/src/device_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'fetch_call_back_request_request.freezed.dart';
part 'fetch_call_back_request_request.g.dart';

@freezed
class FetchCallBackRequestRequest with _$FetchCallBackRequestRequest {
  const factory FetchCallBackRequestRequest({
    /// Dynamic fields mapped directly to root JSON
    @JsonKey(ignore: true) Map<String, dynamic>? dynamicFields, // i added this
    /// Optional device info, ignored in JSON
    @JsonKey(ignore: true) DeviceModel? deviceInfo,
  }) = _FetchCallBackRequestRequest;

  factory FetchCallBackRequestRequest.fromJson(Map<String, dynamic> json) =>
      _$FetchCallBackRequestRequestFromJson(json);
}
