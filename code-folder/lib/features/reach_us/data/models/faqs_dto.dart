import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/faqs.dart';
import './faqs_faq_list_item_dto.dart';

part 'faqs_dto.freezed.dart';
part 'faqs_dto.g.dart';

@freezed
class FaqsDto with _$FaqsDto {
  const factory FaqsDto({
    List<FaqsFaqListItemDto>? faqList,
  }) = _FaqsDto;

  factory FaqsDto.fromJson(Map<String, dynamic> json) => _$FaqsDtoFromJson(json);
}

extension FaqsDtoX on FaqsDto {
  Faqs toEntity() => Faqs(
      faqList: faqList?.map((e)=>e.toEntity()).toList() ?? const [],
  );
}
