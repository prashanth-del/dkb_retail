// GENERATED DTO (Freezed): ApplyProductsDto
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/apply_products.dart';
import './apply_products_sub_product_dto.dart';

part 'apply_products_dto.freezed.dart';
part 'apply_products_dto.g.dart';

@freezed
class ApplyProductsDto with _$ApplyProductsDto {
  const factory ApplyProductsDto({
    int? productId,
    String? productName,
    String? productCategory,
    String? productImage,
    bool? active,
    String? createdAt,
    String? updatedAt,
    List<ApplyProductsSubProductDto>? subProducts,
  }) = _ApplyProductsDto;

  factory ApplyProductsDto.fromJson(Map<String, dynamic> json) => _$ApplyProductsDtoFromJson(json);
}

extension ApplyProductsDtoX on ApplyProductsDto {
  ApplyProducts toEntity() => ApplyProducts(
      productId: productId ?? 0,
      productName: productName ?? "",
      productCategory: productCategory ?? "",
      productImage: productImage ?? "",
      active: active ?? false,
      createdAt: createdAt ?? "",
      updatedAt: updatedAt ?? "",
      subProducts: subProducts?.map((e)=>e.toEntity()).toList() ?? const [],
  );
}
