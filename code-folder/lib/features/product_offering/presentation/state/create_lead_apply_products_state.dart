import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/create_lead_of_products.dart';

part 'create_lead_apply_products_state.freezed.dart';

@freezed
class CreateLeadApplyProductsState with _$CreateLeadApplyProductsState {
  const factory CreateLeadApplyProductsState.initial() = _Initial;
  const factory CreateLeadApplyProductsState.loading() = _Loading;
  const factory CreateLeadApplyProductsState.success(List<CreateLeadOfProducts> data) = _Success;
  const factory CreateLeadApplyProductsState.failure(String message) = _Failure;
}
