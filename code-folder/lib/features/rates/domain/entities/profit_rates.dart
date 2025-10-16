import 'package:freezed_annotation/freezed_annotation.dart';
import './profit_rates_psv_item.dart';
import './profit_rates_ssv_item.dart';
import './profit_rates_pia_item.dart';
import './profit_rates_sav_item.dart';
import './profit_rates_ysv_item.dart';
import './profit_rates_ntd_item.dart';
import './profit_rates_cal_item.dart';

part 'profit_rates.freezed.dart';

@freezed
class ProfitRates with _$ProfitRates {
  const factory ProfitRates({
    required List<ProfitRatesPsvItem> PSV,
    required List<ProfitRatesSsvItem> SSV,
    required List<ProfitRatesPiaItem> PIA,
    required List<ProfitRatesSavItem> SAV,
    required List<ProfitRatesYsvItem> YSV,
    required List<ProfitRatesNtdItem> NTD,
    required List<ProfitRatesCalItem> CAL,
  }) = _ProfitRates;
}
