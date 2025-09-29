import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/platform_transaction_dto.dart';

part 'platform_transaction_entity.freezed.dart';

@freezed
class PlatformTransactionAnalysisEntity
    with _$PlatformTransactionAnalysisEntity {
  const factory PlatformTransactionAnalysisEntity({
    String? totalTransactions,
    List<Platform>? platforms,
  }) = _PlatformTransactionAnalysisEntity;
}
