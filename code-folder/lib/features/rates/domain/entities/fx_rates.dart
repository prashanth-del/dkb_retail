import 'package:freezed_annotation/freezed_annotation.dart';


part 'fx_rates.freezed.dart';

@freezed
class FxRates with _$FxRates {
  const factory FxRates({
    required String isoCode,
    required String isoCodeNum,
    required String curName,
    required String shortCurName,
    required String ttBuy,
    required String ttSell,
  }) = _FxRates;
}
