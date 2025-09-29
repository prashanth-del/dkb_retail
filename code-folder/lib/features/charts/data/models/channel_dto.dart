import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entity/transaction_channel_entity.dart';

part 'channel_dto.freezed.dart';
part 'channel_dto.g.dart';

@freezed
class TrasactionChannelDto with _$TrasactionChannelDto {
  const factory TrasactionChannelDto({
    @JsonKey(name: "channels")
    required List<TrasactionChannel> trasactionChannels,
  }) = _TrasactionChannelDto;

  const TrasactionChannelDto._();

  TrasactionChannelEntity toDomain() {
    return TrasactionChannelEntity(trasactionChannels: trasactionChannels);
  }

  factory TrasactionChannelDto.fromJson(Map<String, dynamic> json) =>
      _$TrasactionChannelDtoFromJson(json);
}

@freezed
class TrasactionChannel with _$TrasactionChannel {
  const factory TrasactionChannel({
    required String id,
    required double success,
    required double failure,
  }) = _TrasactionChannel;

  factory TrasactionChannel.fromJson(Map<String, dynamic> json) =>
      _$TrasactionChannelFromJson(json);
}
