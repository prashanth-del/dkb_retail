import 'package:freezed_annotation/freezed_annotation.dart';
import './faqs_faq_list_item.dart';

part 'faqs.freezed.dart';

@freezed
class Faqs with _$Faqs {
  const factory Faqs({
    required List<FaqsFaqListItem> faqList,
  }) = _Faqs;
}
