import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/bank_products.dart';

part 'fetch_apply_products_state.freezed.dart';

@freezed
class FetchApplyProductsState with _$FetchApplyProductsState {
  const factory FetchApplyProductsState.initial() = _Initial;
  const factory FetchApplyProductsState.loading() = _Loading;
  const factory FetchApplyProductsState.success(List<BankProducts> data) = _Success;
  const factory FetchApplyProductsState.failure(String message) = _Failure;
}
