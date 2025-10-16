import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../domain/entities/profit_rates_ntd_item.dart';


part 'profit_rates_ntd_item_dto.freezed.dart';
part 'profit_rates_ntd_item_dto.g.dart';

@freezed
class ProfitRatesNtdItemDto with _$ProfitRatesNtdItemDto {
  const factory ProfitRatesNtdItemDto({
    String? lastMonthDate,
    String? description,
    String? rate,
    String? rateCreationDate,
    String? productType,
    String? productSubtype,
    String? tenure,
    String? currency,
  }) = _ProfitRatesNtdItemDto;

  factory ProfitRatesNtdItemDto.fromJson(Map<String, dynamic> json) => _$ProfitRatesNtdItemDtoFromJson(json);
}

extension ProfitRatesNtdItemDtoX on ProfitRatesNtdItemDto {
  ProfitRatesNtdItem toEntity() => ProfitRatesNtdItem(
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
