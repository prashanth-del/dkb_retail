import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/transaction_summary_dto.dart';

part 'transaction_summary_entity.freezed.dart';

@freezed
class TransactionSummaryEntity with _$TransactionSummaryEntity {
  const factory TransactionSummaryEntity({
    String? totalTransactions,
    List<Channel>? channels,
  }) = _TransactionSummaryEntity;
}
