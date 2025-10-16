import 'package:freezed_annotation/freezed_annotation.dart';


part 'faqs_faq_list_item.freezed.dart';

@freezed
class FaqsFaqListItem with _$FaqsFaqListItem {
  const factory FaqsFaqListItem({
    required String question,
    required String answer,
  }) = _FaqsFaqListItem;
}
