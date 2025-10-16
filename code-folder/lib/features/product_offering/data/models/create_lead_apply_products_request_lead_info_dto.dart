import 'package:freezed_annotation/freezed_annotation.dart';


part 'create_lead_apply_products_request_lead_info_dto.freezed.dart';
part 'create_lead_apply_products_request_lead_info_dto.g.dart';

@freezed
class CreateLeadApplyProductsRequestLeadInfoDto with _$CreateLeadApplyProductsRequestLeadInfoDto {
  const factory CreateLeadApplyProductsRequestLeadInfoDto({
    String? NameofPerson,
    String? ContactNo,
    String? TypeOfBusiness,
  }) = _CreateLeadApplyProductsRequestLeadInfoDto;

  factory CreateLeadApplyProductsRequestLeadInfoDto.fromJson(Map<String, dynamic> json) => _$CreateLeadApplyProductsRequestLeadInfoDtoFromJson(json);
}
