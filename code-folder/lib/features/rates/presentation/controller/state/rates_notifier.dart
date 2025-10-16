import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../data/models/fx_rates_model/get_fx_rates_request.dart';
import '../../../domain/entities/fx_rates.dart';
import '../../../domain/locator/rates_locator.dart';
import '../../../domain/repository/rates_repository.dart';

part 'rates_notifier.g.dart';

@riverpod
class RatesNotifier extends _$RatesNotifier {
  @override
  AsyncValue<List<FxRates>> build() {
    // Initial state: empty data
    return const AsyncValue.data([]);
  }

  RatesRepository get _ratesRepository => ref.read(ratesRepositoryProvider);

  Future<void> fetchRates({required GetFxRatesRequest request}) async {
    // Set loading state
    state = const AsyncValue.loading();

    try {
      final result = await _ratesRepository.getFxRates(request: request);

      // Handle success / failure
      result.fold(
            (err) {
          state = AsyncValue.error(
            err.description ?? err.mwdesc ?? 'Server Error!',
            StackTrace.current,
          );
        },
            (data) {
          state = AsyncValue.data(data);
        },
      );
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
