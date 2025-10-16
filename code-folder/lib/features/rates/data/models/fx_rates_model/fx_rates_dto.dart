import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../domain/entities/fx_rates.dart';


part 'fx_rates_dto.freezed.dart';
part 'fx_rates_dto.g.dart';

@freezed
class FxRatesDto with _$FxRatesDto {
  const factory FxRatesDto({
    String? isoCode,
    String? isoCodeNum,
    String? curName,
    String? shortCurName,
    String? ttBuy,
    String? ttSell,
  }) = _FxRatesDto;

  factory FxRatesDto.fromJson(Map<String, dynamic> json) => _$FxRatesDtoFromJson(json);
}

extension FxRatesDtoX on FxRatesDto {
  FxRates toEntity() => FxRates(
      isoCode: isoCode ?? "",
      isoCodeNum: isoCodeNum ?? "",
      curName: curName ?? "",
      shortCurName: shortCurName ?? "",
      ttBuy: ttBuy ?? "",
      ttSell: ttSell ?? "",
  );
}
