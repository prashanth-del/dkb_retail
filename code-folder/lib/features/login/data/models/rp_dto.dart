import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/rp.dart';
part 'rp_dto.freezed.dart';
part 'rp_dto.g.dart';

@freezed
class RpDto with _$RpDto {
  const RpDto._();

  const factory RpDto({
    String? kp,
    String? rk,
    String? ocsEncFlag,
    String? key,
  }) = _RpDto;

  Rp toDomain() => Rp(
        kp: kp ?? "",
        rk: rk ?? "",
        ocsEncFlag: ocsEncFlag ?? "",
        key: key ?? "",
      );

  factory RpDto.fromJson(Map<String, dynamic> json) => _$RpDtoFromJson(json);
}
