import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/fx_rates.dart';

part 'get_fx_rates_state.freezed.dart';

@freezed
class GetFxRatesState with _$GetFxRatesState {
  const factory GetFxRatesState.initial() = _Initial;
  const factory GetFxRatesState.loading() = _Loading;
  const factory GetFxRatesState.success(List<FxRates> data) = _Success;
  const factory GetFxRatesState.failure(String message) = _Failure;
}
