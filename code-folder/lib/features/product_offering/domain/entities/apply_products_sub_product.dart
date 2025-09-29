// GENERATED Entity (Freezed): ApplyProductsSubProduct
import 'package:freezed_annotation/freezed_annotation.dart';


part 'apply_products_sub_product.freezed.dart';

@freezed
class ApplyProductsSubProduct with _$ApplyProductsSubProduct {
  const factory ApplyProductsSubProduct({
    required int subProductId,
    required String subProductName,
    required String subProductCategory,
    required String subProductImage,
    required String description,
    required bool active,
    required String createdAt,
    required String updatedAt,
  }) = _ApplyProductsSubProduct;
}
