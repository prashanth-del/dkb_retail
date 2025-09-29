import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entity/transaction_analysis_entity.dart';

part 'transaction_analysis_dto.freezed.dart';
part 'transaction_analysis_dto.g.dart';

@freezed
class TransactionAnalysisDto with _$TransactionAnalysisDto {
  const factory TransactionAnalysisDto({
    double? totalTransactions,
    List<TransactionService>? services,
  }) = _TransactionAnalysisDto;

  const TransactionAnalysisDto._();

  TransactionAnalysisEntity toDomain() {
    return TransactionAnalysisEntity(
        totalTransactions: totalTransactions, services: services);
  }

  factory TransactionAnalysisDto.fromJson(Map<String, dynamic> json) =>
      _$TransactionAnalysisDtoFromJson(json);
}

@freezed
class TransactionService with _$TransactionService {
  const factory TransactionService({
    required String serviceType,
    required double successCount,
    required double failureCount,
    required List<TransactionChannelBreakdown> channelBreakdown,
    required String? successRate,
    required String? failureRate,
  }) = _TransactionService;

  factory TransactionService.fromJson(Map<String, dynamic> json) =>
      _$TransactionServiceFromJson(json);
}

@freezed
class TransactionChannelBreakdown with _$TransactionChannelBreakdown {
  const factory TransactionChannelBreakdown({
    required String channelId,
    required double successCount,
    required double failureCount,
    required List<TransactionFailureReason> failureReasons,
  }) = _TransactionChannelBreakdown;

  factory TransactionChannelBreakdown.fromJson(Map<String, dynamic> json) =>
      _$TransactionChannelBreakdownFromJson(json);
}

@freezed
class TransactionFailureReason with _$TransactionFailureReason {
  const factory TransactionFailureReason({
    required String reason,
    required double count,
  }) = _TransactionFailureReason;

  factory TransactionFailureReason.fromJson(Map<String, dynamic> json) =>
      _$TransactionFailureReasonFromJson(json);
}
