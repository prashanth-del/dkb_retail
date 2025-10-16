import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/sub_products_images.dart';


part 'sub_products_images_dto.freezed.dart';
part 'sub_products_images_dto.g.dart';

@freezed
class SubProductsImagesDto with _$SubProductsImagesDto {
  const factory SubProductsImagesDto({
    String? image,
  }) = _SubProductsImagesDto;

  factory SubProductsImagesDto.fromJson(Map<String, dynamic> json) => _$SubProductsImagesDtoFromJson(json);
}

extension SubProductsImagesDtoX on SubProductsImagesDto {
  SubProductsImages toEntity() => SubProductsImages(
      image: image ?? "",
  );
}
