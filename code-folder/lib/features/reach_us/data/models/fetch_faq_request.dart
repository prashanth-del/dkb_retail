import 'package:db_uicomponents/src/utils/device_info/src/device_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'fetch_faq_request.freezed.dart';
part 'fetch_faq_request.g.dart';

@freezed
class FetchFaqRequest with _$FetchFaqRequest {
  const factory FetchFaqRequest({
    @JsonKey(ignore: true) DeviceModel? deviceInfo,
  }) = _FetchFaqRequest;

  factory FetchFaqRequest.fromJson(Map<String, dynamic> json) =>
      _$FetchFaqRequestFromJson(json);
}
