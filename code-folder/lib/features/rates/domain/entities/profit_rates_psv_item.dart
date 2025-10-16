import 'package:freezed_annotation/freezed_annotation.dart';


part 'profit_rates_psv_item.freezed.dart';

@freezed
class ProfitRatesPsvItem with _$ProfitRatesPsvItem {
  const factory ProfitRatesPsvItem({
    required String lastMonthDate,
    required String description,
    required String rate,
    required String rateCreationDate,
    required String productType,
    required String productSubtype,
    required String tenure,
    required String currency,
  }) = _ProfitRatesPsvItem;
}
