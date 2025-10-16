import 'package:freezed_annotation/freezed_annotation.dart';


part 'profit_rates_sav_item.freezed.dart';

@freezed
class ProfitRatesSavItem with _$ProfitRatesSavItem {
  const factory ProfitRatesSavItem({
    required String lastMonthDate,
    required String description,
    required String rate,
    required String rateCreationDate,
    required String productType,
    required String productSubtype,
    required String tenure,
    required String currency,
  }) = _ProfitRatesSavItem;
}
