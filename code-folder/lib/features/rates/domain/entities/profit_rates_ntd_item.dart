import 'package:freezed_annotation/freezed_annotation.dart';


part 'profit_rates_ntd_item.freezed.dart';

@freezed
class ProfitRatesNtdItem with _$ProfitRatesNtdItem {
  const factory ProfitRatesNtdItem({
    required String lastMonthDate,
    required String description,
    required String rate,
    required String rateCreationDate,
    required String productType,
    required String productSubtype,
    required String tenure,
    required String currency,
  }) = _ProfitRatesNtdItem;
}
