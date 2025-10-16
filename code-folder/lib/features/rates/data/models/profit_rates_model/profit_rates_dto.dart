import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../domain/entities/profit_rates.dart';
import './profit_rates_psv_item_dto.dart';
import './profit_rates_ssv_item_dto.dart';
import './profit_rates_pia_item_dto.dart';
import './profit_rates_sav_item_dto.dart';
import './profit_rates_ysv_item_dto.dart';
import './profit_rates_ntd_item_dto.dart';
import './profit_rates_cal_item_dto.dart';

part 'profit_rates_dto.freezed.dart';
part 'profit_rates_dto.g.dart';

@freezed
class ProfitRatesDto with _$ProfitRatesDto {
  const factory ProfitRatesDto({
    List<ProfitRatesPsvItemDto>? PSV,
    List<ProfitRatesSsvItemDto>? SSV,
    List<ProfitRatesPiaItemDto>? PIA,
    List<ProfitRatesSavItemDto>? SAV,
    List<ProfitRatesYsvItemDto>? YSV,
    List<ProfitRatesNtdItemDto>? NTD,
    List<ProfitRatesCalItemDto>? CAL,
  }) = _ProfitRatesDto;

  factory ProfitRatesDto.fromJson(Map<String, dynamic> json) => _$ProfitRatesDtoFromJson(json);
}

extension ProfitRatesDtoX on ProfitRatesDto {
  ProfitRates toEntity() => ProfitRates(
      PSV: PSV?.map((e)=>e.toEntity()).toList() ?? const [],
      SSV: SSV?.map((e)=>e.toEntity()).toList() ?? const [],
      PIA: PIA?.map((e)=>e.toEntity()).toList() ?? const [],
      SAV: SAV?.map((e)=>e.toEntity()).toList() ?? const [],
      YSV: YSV?.map((e)=>e.toEntity()).toList() ?? const [],
      NTD: NTD?.map((e)=>e.toEntity()).toList() ?? const [],
      CAL: CAL?.map((e)=>e.toEntity()).toList() ?? const [],
  );
}
