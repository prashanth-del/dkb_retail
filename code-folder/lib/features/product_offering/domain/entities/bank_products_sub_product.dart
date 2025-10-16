import 'package:freezed_annotation/freezed_annotation.dart';


part 'bank_products_sub_product.freezed.dart';

@freezed
class BankProductsSubProduct with _$BankProductsSubProduct {
  const factory BankProductsSubProduct({
    required int subProductId,
    required String subProductName,
    required String subProductCategory,
    required String description,
    required bool active,
    required String createdAt,
    required String updatedAt,
  }) = _BankProductsSubProduct;
}
