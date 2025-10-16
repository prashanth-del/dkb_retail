import 'package:freezed_annotation/freezed_annotation.dart';


part 'profit_rates_ssv_item.freezed.dart';

@freezed
class ProfitRatesSsvItem with _$ProfitRatesSsvItem {
  const factory ProfitRatesSsvItem({
    required String lastMonthDate,
    required String description,
    required String rate,
    required String rateCreationDate,
    required String productType,
    required String productSubtype,
    required String tenure,
    required String currency,
  }) = _ProfitRatesSsvItem;
}
