import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../domain/entities/profit_rates_ssv_item.dart';


part 'profit_rates_ssv_item_dto.freezed.dart';
part 'profit_rates_ssv_item_dto.g.dart';

@freezed
class ProfitRatesSsvItemDto with _$ProfitRatesSsvItemDto {
  const factory ProfitRatesSsvItemDto({
    String? lastMonthDate,
    String? description,
    String? rate,
    String? rateCreationDate,
    String? productType,
    String? productSubtype,
    String? tenure,
    String? currency,
  }) = _ProfitRatesSsvItemDto;

  factory ProfitRatesSsvItemDto.fromJson(Map<String, dynamic> json) => _$ProfitRatesSsvItemDtoFromJson(json);
}

extension ProfitRatesSsvItemDtoX on ProfitRatesSsvItemDto {
  ProfitRatesSsvItem toEntity() => ProfitRatesSsvItem(
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
