import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:db_uicomponents/src/utils/device_info/src/device_model.dart';


part 'get_profit_rates_request.freezed.dart';
part 'get_profit_rates_request.g.dart';

@freezed
class GetProfitRatesRequest with _$GetProfitRatesRequest {
  const factory GetProfitRatesRequest({

    @JsonKey(ignore: true) DeviceModel? deviceInfo,
  }) = _GetProfitRatesRequest;

  factory GetProfitRatesRequest.fromJson(Map<String, dynamic> json) => _$GetProfitRatesRequestFromJson(json);
}
