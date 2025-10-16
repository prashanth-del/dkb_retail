import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/create_lead_of_products.dart';


part 'create_lead_of_products_dto.freezed.dart';
part 'create_lead_of_products_dto.g.dart';

@freezed
class CreateLeadOfProductsDto with _$CreateLeadOfProductsDto {
  const factory CreateLeadOfProductsDto({
    String? returnCodeDescProvider,
    String? returnCodeProvider,
  }) = _CreateLeadOfProductsDto;

  factory CreateLeadOfProductsDto.fromJson(Map<String, dynamic> json) => _$CreateLeadOfProductsDtoFromJson(json);
}

extension CreateLeadOfProductsDtoX on CreateLeadOfProductsDto {
  CreateLeadOfProducts toEntity() => CreateLeadOfProducts(
      returnCodeDescProvider: returnCodeDescProvider ?? "",
      returnCodeProvider: returnCodeProvider ?? "",
  );
}
