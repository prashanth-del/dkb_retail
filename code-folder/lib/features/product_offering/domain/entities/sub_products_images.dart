import 'package:freezed_annotation/freezed_annotation.dart';


part 'sub_products_images.freezed.dart';

@freezed
class SubProductsImages with _$SubProductsImages {
  const factory SubProductsImages({
    required String image,
  }) = _SubProductsImages;
}
