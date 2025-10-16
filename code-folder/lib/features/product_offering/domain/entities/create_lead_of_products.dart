import 'package:freezed_annotation/freezed_annotation.dart';


part 'create_lead_of_products.freezed.dart';

@freezed
class CreateLeadOfProducts with _$CreateLeadOfProducts {
  const factory CreateLeadOfProducts({
    required String returnCodeDescProvider,
    required String returnCodeProvider,
  }) = _CreateLeadOfProducts;
}
