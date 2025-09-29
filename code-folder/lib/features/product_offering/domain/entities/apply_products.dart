// GENERATED Entity (Freezed): ApplyProducts
import 'package:freezed_annotation/freezed_annotation.dart';
import './apply_products_sub_product.dart';

part 'apply_products.freezed.dart';

@freezed
class ApplyProducts with _$ApplyProducts {
  const factory ApplyProducts({
    required int productId,
    required String productName,
    required String productCategory,
    required String productImage,
    required bool active,
    required String createdAt,
    required String updatedAt,
    required List<ApplyProductsSubProduct> subProducts,
  }) = _ApplyProducts;
}
