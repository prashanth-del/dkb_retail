import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/profit_rates_pia_item.dart';


part 'profit_rates_pia_item_dto.freezed.dart';
part 'profit_rates_pia_item_dto.g.dart';

@freezed
class ProfitRatesPiaItemDto with _$ProfitRatesPiaItemDto {
  const factory ProfitRatesPiaItemDto({
    String? lastMonthDate,
    String? description,
    String? rate,
    String? rateCreationDate,
    String? productType,
    String? productSubtype,
    String? tenure,
    String? currency,
  }) = _ProfitRatesPiaItemDto;

  factory ProfitRatesPiaItemDto.fromJson(Map<String, dynamic> json) => _$ProfitRatesPiaItemDtoFromJson(json);
}

extension ProfitRatesPiaItemDtoX on ProfitRatesPiaItemDto {
  ProfitRatesPiaItem toEntity() => ProfitRatesPiaItem(
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
