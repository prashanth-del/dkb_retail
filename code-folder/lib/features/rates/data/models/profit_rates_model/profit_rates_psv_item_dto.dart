import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../domain/entities/profit_rates_psv_item.dart';


part 'profit_rates_psv_item_dto.freezed.dart';
part 'profit_rates_psv_item_dto.g.dart';

@freezed
class ProfitRatesPsvItemDto with _$ProfitRatesPsvItemDto {
  const factory ProfitRatesPsvItemDto({
    String? lastMonthDate,
    String? description,
    String? rate,
    String? rateCreationDate,
    String? productType,
    String? productSubtype,
    String? tenure,
    String? currency,
  }) = _ProfitRatesPsvItemDto;

  factory ProfitRatesPsvItemDto.fromJson(Map<String, dynamic> json) => _$ProfitRatesPsvItemDtoFromJson(json);
}

extension ProfitRatesPsvItemDtoX on ProfitRatesPsvItemDto {
  ProfitRatesPsvItem toEntity() => ProfitRatesPsvItem(
      lastMonthDate: lastMonthDate ?? "",
      description: description ?? "",
      rate: rate ?? "",
      rateCreationDate: rateCreationDate ?? "",
      productType: productType ?? "",
      productSubtype: productSubtype ?? "",
      tenure: tenure ?? "",
      currency: currency ?? "",
  );
}
