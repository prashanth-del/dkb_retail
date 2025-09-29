import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/transaction_analysis_dto.dart';

part 'transaction_analysis_entity.freezed.dart';

@freezed
class TransactionAnalysisEntity with _$TransactionAnalysisEntity {
  const factory TransactionAnalysisEntity({
    double? totalTransactions,
    List<TransactionService>? services,
  }) = _TransactionAnalysisEntity;
}
