// GENERATED DTO (Freezed): ApplyProductsSubProductDto
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/apply_products_sub_product.dart';


part 'apply_products_sub_product_dto.freezed.dart';
part 'apply_products_sub_product_dto.g.dart';

@freezed
class ApplyProductsSubProductDto with _$ApplyProductsSubProductDto {
  const factory ApplyProductsSubProductDto({
    int? subProductId,
    String? subProductName,
    String? subProductCategory,
    String? subProductImage,
    String? description,
    bool? active,
    String? createdAt,
    String? updatedAt,
  }) = _ApplyProductsSubProductDto;

  factory ApplyProductsSubProductDto.fromJson(Map<String, dynamic> json) => _$ApplyProductsSubProductDtoFromJson(json);
}

extension ApplyProductsSubProductDtoX on ApplyProductsSubProductDto {
  ApplyProductsSubProduct toEntity() => ApplyProductsSubProduct(
      subProductId: subProductId ?? 0,
      subProductName: subProductName ?? "",
      subProductCategory: subProductCategory ?? "",
      subProductImage: subProductImage ?? "",
      description: description ?? "",
      active: active ?? false,
      createdAt: createdAt ?? "",
      updatedAt: updatedAt ?? "",
  );
}
