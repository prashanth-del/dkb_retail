import 'package:freezed_annotation/freezed_annotation.dart';


part 'profit_rates_pia_item.freezed.dart';

@freezed
class ProfitRatesPiaItem with _$ProfitRatesPiaItem {
  const factory ProfitRatesPiaItem({
    required String lastMonthDate,
    required String description,
    required String rate,
    required String rateCreationDate,
    required String productType,
    required String productSubtype,
    required String tenure,
    required String currency,
  }) = _ProfitRatesPiaItem;
}
