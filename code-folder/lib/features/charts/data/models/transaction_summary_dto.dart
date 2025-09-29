import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entity/transaction_summary_entity.dart';

part 'transaction_summary_dto.freezed.dart';
part 'transaction_summary_dto.g.dart';

@freezed
class TransactionSummaryDto with _$TransactionSummaryDto {
  const factory TransactionSummaryDto({
    String? totalTransactions,
    List<Channel>? channels,
  }) = _TransactionSummaryDto;

  const TransactionSummaryDto._();

  TransactionSummaryEntity toDomain() {
    return TransactionSummaryEntity(
        totalTransactions: totalTransactions, channels: channels);
  }

  factory TransactionSummaryDto.fromJson(Map<String, dynamic> json) =>
      _$TransactionSummaryDtoFromJson(json);
}

@freezed
class Channel with _$Channel {
  const factory Channel({
    String? totalTransactions,
    String? webTransactions,
    String? mobileTransactions,
    String? channelName,
    String? channelId,
  }) = _Channel;

  factory Channel.fromJson(Map<String, dynamic> json) =>
      _$ChannelFromJson(json);
}
