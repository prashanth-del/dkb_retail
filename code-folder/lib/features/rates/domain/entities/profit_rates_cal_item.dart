import 'package:freezed_annotation/freezed_annotation.dart';


part 'profit_rates_cal_item.freezed.dart';

@freezed
class ProfitRatesCalItem with _$ProfitRatesCalItem {
  const factory ProfitRatesCalItem({
    required String lastMonthDate,
    required String description,
    required String rate,
    required String rateCreationDate,
    required String productType,
    required String productSubtype,
    required String tenure,
    required String currency,
  }) = _ProfitRatesCalItem;
}
