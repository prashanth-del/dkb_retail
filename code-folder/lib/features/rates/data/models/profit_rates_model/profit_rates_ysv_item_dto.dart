import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../domain/entities/profit_rates_ysv_item.dart';


part 'profit_rates_ysv_item_dto.freezed.dart';
part 'profit_rates_ysv_item_dto.g.dart';

@freezed
class ProfitRatesYsvItemDto with _$ProfitRatesYsvItemDto {
  const factory ProfitRatesYsvItemDto({
    String? lastMonthDate,
    String? description,
    String? rate,
    String? rateCreationDate,
    String? productType,
    String? productSubtype,
    String? tenure,
    String? currency,
  }) = _ProfitRatesYsvItemDto;

  factory ProfitRatesYsvItemDto.fromJson(Map<String, dynamic> json) => _$ProfitRatesYsvItemDtoFromJson(json);
}

extension ProfitRatesYsvItemDtoX on ProfitRatesYsvItemDto {
  ProfitRatesYsvItem toEntity() => ProfitRatesYsvItem(
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
