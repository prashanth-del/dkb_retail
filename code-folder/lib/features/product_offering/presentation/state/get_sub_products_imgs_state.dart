import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/sub_products_images.dart';

part 'get_sub_products_imgs_state.freezed.dart';

@freezed
class GetSubProductsImgsState with _$GetSubProductsImgsState {
  const factory GetSubProductsImgsState.initial() = _Initial;
  const factory GetSubProductsImgsState.loading() = _Loading;
  const factory GetSubProductsImgsState.success(List<SubProductsImages> data) = _Success;
  const factory GetSubProductsImgsState.failure(String message) = _Failure;
}
