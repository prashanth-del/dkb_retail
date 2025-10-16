import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:db_uicomponents/src/utils/device_info/src/device_model.dart';


part 'get_fx_rates_request.freezed.dart';
part 'get_fx_rates_request.g.dart';

@freezed
class GetFxRatesRequest with _$GetFxRatesRequest {
  const factory GetFxRatesRequest({

    @JsonKey(ignore: true) DeviceModel? deviceInfo,
  }) = _GetFxRatesRequest;

  factory GetFxRatesRequest.fromJson(Map<String, dynamic> json) => _$GetFxRatesRequestFromJson(json);
}
