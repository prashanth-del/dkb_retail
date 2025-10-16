import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/fx_rates.dart';

part 'fx_rates_state.freezed.dart';

@freezed
class FxRatesState with _$FxRatesState {
  const factory FxRatesState.initial() = _Initial;
  const factory FxRatesState.loading() = _Loading;
  const factory FxRatesState.success(List<FxRates> rates) = _Success;
  const factory FxRatesState.failure(String message) = _Failure;
}
