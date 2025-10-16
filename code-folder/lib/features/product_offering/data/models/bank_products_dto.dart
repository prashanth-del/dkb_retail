import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/bank_products.dart';
import './bank_products_sub_product_dto.dart';

part 'bank_products_dto.freezed.dart';
part 'bank_products_dto.g.dart';

@freezed
class BankProductsDto with _$BankProductsDto {
  const factory BankProductsDto({
    int? productId,
    String? productName,
    String? productCategory,
    String? productImage,
    bool? active,
    String? createdAt,
    String? updatedAt,
    List<BankProductsSubProductDto>? subProducts,
  }) = _BankProductsDto;

  factory BankProductsDto.fromJson(Map<String, dynamic> json) => _$BankProductsDtoFromJson(json);
}

extension BankProductsDtoX on BankProductsDto {
  BankProducts toEntity() => BankProducts(
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
