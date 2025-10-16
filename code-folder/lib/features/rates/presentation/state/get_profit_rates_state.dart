import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/profit_rates.dart';

part 'get_profit_rates_state.freezed.dart';

@freezed
class GetProfitRatesState with _$GetProfitRatesState {
  const factory GetProfitRatesState.initial() = _Initial;
  const factory GetProfitRatesState.loading() = _Loading;
  const factory GetProfitRatesState.success(List<ProfitRates> data) = _Success;
  const factory GetProfitRatesState.failure(String message) = _Failure;
}
