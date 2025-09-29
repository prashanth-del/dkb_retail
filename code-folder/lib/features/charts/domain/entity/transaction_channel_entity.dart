import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/channel_dto.dart';

part 'transaction_channel_entity.freezed.dart';

@freezed
class TrasactionChannelEntity with _$TrasactionChannelEntity {
  const factory TrasactionChannelEntity({
    required List<TrasactionChannel> trasactionChannels,
  }) = _TrasactionChannelEntity;
}
