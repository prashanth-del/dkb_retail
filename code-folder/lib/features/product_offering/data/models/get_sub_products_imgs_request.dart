import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:db_uicomponents/src/utils/device_info/src/device_model.dart';


part 'get_sub_products_imgs_request.freezed.dart';
part 'get_sub_products_imgs_request.g.dart';

@freezed
class GetSubProductsImgsRequest with _$GetSubProductsImgsRequest {
  const factory GetSubProductsImgsRequest({

    @JsonKey(ignore: true) DeviceModel? deviceInfo,
  }) = _GetSubProductsImgsRequest;

  factory GetSubProductsImgsRequest.fromJson(Map<String, dynamic> json) => _$GetSubProductsImgsRequestFromJson(json);
}
