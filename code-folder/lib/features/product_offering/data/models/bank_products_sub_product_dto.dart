import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/bank_products_sub_product.dart';


part 'bank_products_sub_product_dto.freezed.dart';
part 'bank_products_sub_product_dto.g.dart';

@freezed
class BankProductsSubProductDto with _$BankProductsSubProductDto {
  const factory BankProductsSubProductDto({
    int? subProductId,
    String? subProductName,
    String? subProductCategory,
    String? description,
    bool? active,
    String? createdAt,
    String? updatedAt,
  }) = _BankProductsSubProductDto;

  factory BankProductsSubProductDto.fromJson(Map<String, dynamic> json) => _$BankProductsSubProductDtoFromJson(json);
}

extension BankProductsSubProductDtoX on BankProductsSubProductDto {
  BankProductsSubProduct toEntity() => BankProductsSubProduct(
      subProductId: subProductId ?? 0,
      subProductName: subProductName ?? "",
      subProductCategory: subProductCategory ?? "",
      description: description ?? "",
      active: active ?? false,
      createdAt: createdAt ?? "",
      updatedAt: updatedAt ?? "",
  );
}
