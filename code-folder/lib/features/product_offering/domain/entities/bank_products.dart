import 'package:freezed_annotation/freezed_annotation.dart';
import './bank_products_sub_product.dart';

part 'bank_products.freezed.dart';

@freezed
class BankProducts with _$BankProducts {
  const factory BankProducts({
    required int productId,
    required String productName,
    required String productCategory,
    required String productImage,
    required bool active,
    required String createdAt,
    required String updatedAt,
    required List<BankProductsSubProduct> subProducts,
  }) = _BankProducts;
}
