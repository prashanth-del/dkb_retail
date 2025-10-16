import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:db_uicomponents/src/utils/device_info/src/device_model.dart';


part 'fetch_locate_us_info_request.freezed.dart';
part 'fetch_locate_us_info_request.g.dart';

@freezed
class FetchLocateUsInfoRequest with _$FetchLocateUsInfoRequest {
  const factory FetchLocateUsInfoRequest({

    @JsonKey(ignore: true) DeviceModel? deviceInfo,
  }) = _FetchLocateUsInfoRequest;

  factory FetchLocateUsInfoRequest.fromJson(Map<String, dynamic> json) => _$FetchLocateUsInfoRequestFromJson(json);
}
