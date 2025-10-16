import 'dart:async';
import 'package:dkb_retail/features/rates/domain/entities/profit_rates.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../data/models/profit_rates_model/get_profit_rates_request.dart';
import '../../../domain/locator/rates_locator.dart';
import '../../../domain/repository/rates_repository.dart';

part 'profit_rates_notifier.g.dart';

@riverpod
class ProfitRatesNotifier extends _$ProfitRatesNotifier {
  @override
  AsyncValue<ProfitRates> build() {
    return const AsyncValue.data(
      ProfitRates(
        PSV: [],
        SSV: [],
        PIA: [],
        SAV: [],
        YSV: [],
        NTD: [],
        CAL: [],
      ),
    );
  }

  RatesRepository get _ratesRepository => ref.read(ratesRepositoryProvider);

  Future<void> fetchProfitRates({required GetProfitRatesRequest request}) async {
    state = const AsyncValue.loading();

    try {
      final result = await _ratesRepository.getProfitRates(request: request);

      result.fold(
            (err) {
          state = AsyncValue.error(
            err.description ?? err.mwdesc ?? 'Server Error!',
            StackTrace.current,
          );
        },
            (dataList) {
          // Already entities, no toEntity()
          final profitRates = dataList.isNotEmpty
              ? dataList.first
              : const ProfitRates(
            PSV: [],
            SSV: [],
            PIA: [],
            SAV: [],
            YSV: [],
            NTD: [],
            CAL: [],
          );

          state = AsyncValue.data(profitRates);
        },
      );
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

}

