import 'package:freezed_annotation/freezed_annotation.dart';


part 'profit_rates_ysv_item.freezed.dart';

@freezed
class ProfitRatesYsvItem with _$ProfitRatesYsvItem {
  const factory ProfitRatesYsvItem({
    required String lastMonthDate,
    required String description,
    required String rate,
    required String rateCreationDate,
    required String productType,
    required String productSubtype,
    required String tenure,
    required String currency,
  }) = _ProfitRatesYsvItem;
}
