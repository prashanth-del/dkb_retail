import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:dartz/dartz.dart';
import '../state/fetch_bank_info_state.dart';
import '../../domain/repositories/reach_us_repository.dart';
import '../reach_us_providers.dart';
import '../../data/models/fetch_bank_info_request.dart';

part 'fetch_bank_info_notifier.g.dart';

@riverpod
class FetchBankInfoNotifier extends _$FetchBankInfoNotifier {
  @override
  FetchBankInfoState build() => const FetchBankInfoState.initial();

  ReachUsRepository get _repo => ref.read(reachUsRepoProvider);

    Future<void> fetchBankInfo({ required FetchBankInfoRequest request, }) async {
    state = const FetchBankInfoState.loading();
    final result = await _repo.fetchBankInfo(request: request);

    result.fold(
      (err) => state = FetchBankInfoState.failure(err.description ?? err.mwdesc ?? 'Server Error!'),
      (data) {
        state = FetchBankInfoState.success(data);
      },
    );
  }
}
