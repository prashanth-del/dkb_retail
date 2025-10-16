import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:db_uicomponents/src/utils/device_info/src/device_model.dart';


part 'fetch_bank_info_request.freezed.dart';
part 'fetch_bank_info_request.g.dart';

@freezed
class FetchBankInfoRequest with _$FetchBankInfoRequest {
  const factory FetchBankInfoRequest({

    @JsonKey(ignore: true) DeviceModel? deviceInfo,
  }) = _FetchBankInfoRequest;

  factory FetchBankInfoRequest.fromJson(Map<String, dynamic> json) => _$FetchBankInfoRequestFromJson(json);
}
