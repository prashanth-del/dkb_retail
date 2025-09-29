import 'package:freezed_annotation/freezed_annotation.dart';

part 'rp.freezed.dart';

@freezed
class Rp with _$Rp {
  const factory Rp({
    required String kp,
    required String rk,
    required String ocsEncFlag,
    required String key,
  }) = _Rp;
}
