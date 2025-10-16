import 'package:db_uicomponents/src/utils/device_info/src/device_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import './create_lead_apply_products_request_lead_info_dto.dart';

part 'create_lead_apply_products_request.freezed.dart';
part 'create_lead_apply_products_request.g.dart';

@freezed
class CreateLeadApplyProductsRequest with _$CreateLeadApplyProductsRequest {
  const factory CreateLeadApplyProductsRequest({
    CreateLeadApplyProductsRequestLeadInfoDto? requestInfo,
    @JsonKey(ignore: true) DeviceModel? deviceInfo,
  }) = _CreateLeadApplyProductsRequest;

  factory CreateLeadApplyProductsRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateLeadApplyProductsRequestFromJson(json);
}
