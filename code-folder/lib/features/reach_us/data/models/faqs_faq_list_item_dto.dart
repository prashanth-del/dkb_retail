import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/faqs_faq_list_item.dart';


part 'faqs_faq_list_item_dto.freezed.dart';
part 'faqs_faq_list_item_dto.g.dart';

@freezed
class FaqsFaqListItemDto with _$FaqsFaqListItemDto {
  const factory FaqsFaqListItemDto({
    String? question,
    String? answer,
  }) = _FaqsFaqListItemDto;

  factory FaqsFaqListItemDto.fromJson(Map<String, dynamic> json) => _$FaqsFaqListItemDtoFromJson(json);
}

extension FaqsFaqListItemDtoX on FaqsFaqListItemDto {
  FaqsFaqListItem toEntity() => FaqsFaqListItem(
      question: question ?? "",
      answer: answer ?? "",
  );
}
