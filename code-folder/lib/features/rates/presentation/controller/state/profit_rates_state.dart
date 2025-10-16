import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../domain/entities/profit_rates.dart';

part 'profit_rates_state.freezed.dart';

@freezed
class ProfitRatesState with _$ProfitRatesState {
  const factory ProfitRatesState.initial() = _Initial;
  const factory ProfitRatesState.loading() = _Loading;
  const factory ProfitRatesState.success(List<ProfitRates> rates) = _Success;
  const factory ProfitRatesState.failure(String message) = _Failure;
}
