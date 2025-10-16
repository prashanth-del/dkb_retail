import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../domain/entities/profit_rates_sav_item.dart';


part 'profit_rates_sav_item_dto.freezed.dart';
part 'profit_rates_sav_item_dto.g.dart';

@freezed
class ProfitRatesSavItemDto with _$ProfitRatesSavItemDto {
  const factory ProfitRatesSavItemDto({
    String? lastMonthDate,
    String? description,
    String? rate,
    String? rateCreationDate,
    String? productType,
    String? productSubtype,
    String? tenure,
    String? currency,
  }) = _ProfitRatesSavItemDto;

  factory ProfitRatesSavItemDto.fromJson(Map<String, dynamic> json) => _$ProfitRatesSavItemDtoFromJson(json);
}

extension ProfitRatesSavItemDtoX on ProfitRatesSavItemDto {
  ProfitRatesSavItem toEntity() => ProfitRatesSavItem(
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
