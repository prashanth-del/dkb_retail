import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entity/platform_transaction_entity.dart';

part 'platform_transaction_dto.freezed.dart';
part 'platform_transaction_dto.g.dart';

@freezed
class PlatformTransactionAnalysisDto with _$PlatformTransactionAnalysisDto {
  const factory PlatformTransactionAnalysisDto({
    String? totalTransactions,
    List<Platform>? platforms,
  }) = _PlatformTransactionAnalysisDto;

  const PlatformTransactionAnalysisDto._();

  PlatformTransactionAnalysisEntity toDomain() {
    return PlatformTransactionAnalysisEntity(
        totalTransactions: totalTransactions, platforms: platforms);
  }

  factory PlatformTransactionAnalysisDto.fromJson(Map<String, dynamic> json) =>
      _$PlatformTransactionAnalysisDtoFromJson(json);
}

@freezed
class Platform with _$Platform {
  const factory Platform({
    required String transactionType,
    required String transactionCount,
    required List<PlatformChannelBreakdown> channelBreakdown,
  }) = _Platform;

  factory Platform.fromJson(Map<String, dynamic> json) =>
      _$PlatformFromJson(json);
}

@freezed
class PlatformChannelBreakdown with _$PlatformChannelBreakdown {
  const factory PlatformChannelBreakdown(
      {required String channelId,
      required String transactionCount,
      @Default("") String transactionType}) = _PlatformChannelBreakdown;

  factory PlatformChannelBreakdown.fromJson(Map<String, dynamic> json) =>
      _$PlatformChannelBreakdownFromJson(json);
}
