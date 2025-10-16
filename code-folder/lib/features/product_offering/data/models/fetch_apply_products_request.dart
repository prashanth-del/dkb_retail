import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:db_uicomponents/src/utils/device_info/src/device_model.dart';
import './fetch_apply_products_request_user_info_dto.dart';

part 'fetch_apply_products_request.freezed.dart';
part 'fetch_apply_products_request.g.dart';

@freezed
class FetchApplyProductsRequest with _$FetchApplyProductsRequest {
  const factory FetchApplyProductsRequest({
    FetchApplyProductsRequestUserInfoDto? userInfo,
    @JsonKey(ignore: true) DeviceModel? deviceInfo,
  }) = _FetchApplyProductsRequest;

  factory FetchApplyProductsRequest.fromJson(Map<String, dynamic> json) => _$FetchApplyProductsRequestFromJson(json);
}
