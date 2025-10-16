import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../domain/entities/profit_rates_cal_item.dart';


part 'profit_rates_cal_item_dto.freezed.dart';
part 'profit_rates_cal_item_dto.g.dart';

@freezed
class ProfitRatesCalItemDto with _$ProfitRatesCalItemDto {
  const factory ProfitRatesCalItemDto({
    String? lastMonthDate,
    String? description,
    String? rate,
    String? rateCreationDate,
    String? productType,
    String? productSubtype,
    String? tenure,
    String? currency,
  }) = _ProfitRatesCalItemDto;

  factory ProfitRatesCalItemDto.fromJson(Map<String, dynamic> json) => _$ProfitRatesCalItemDtoFromJson(json);
}

extension ProfitRatesCalItemDtoX on ProfitRatesCalItemDto {
  ProfitRatesCalItem toEntity() => ProfitRatesCalItem(
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
