import 'package:freezed_annotation/freezed_annotation.dart';


part 'fetch_apply_products_request_user_info_dto.freezed.dart';
part 'fetch_apply_products_request_user_info_dto.g.dart';

@freezed
class FetchApplyProductsRequestUserInfoDto with _$FetchApplyProductsRequestUserInfoDto {
  const factory FetchApplyProductsRequestUserInfoDto({
    String? userName,
    String? role,
    String? action,
    String? userId,
  }) = _FetchApplyProductsRequestUserInfoDto;

  factory FetchApplyProductsRequestUserInfoDto.fromJson(Map<String, dynamic> json) => _$FetchApplyProductsRequestUserInfoDtoFromJson(json);
}
