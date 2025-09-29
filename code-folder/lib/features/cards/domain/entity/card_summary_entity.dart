import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/model/card_summary_model.dart';

part 'card_summary_entity.freezed.dart';

@freezed
class CardSummaryEntity with _$CardSummaryEntity {
  const factory CardSummaryEntity({
    required List<CreditInfo> totalAvailableCreditLimit,
    required List<CreditInfo> totalOutstandingBalance,
    required int totalCard,
    required List<CardSummary> cardSummary,
  }) = _CardSummaryEntity;
}
