import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:dartz/dartz.dart';
import '../state/fetch_faq_state.dart';
import '../../domain/repositories/reach_us_repository.dart';
import '../reach_us_providers.dart';
import '../../data/models/fetch_faq_request.dart';

part 'fetch_faq_notifier.g.dart';

@riverpod
class FetchFaqNotifier extends _$FetchFaqNotifier {
  @override
  FetchFaqState build() => const FetchFaqState.initial();

  ReachUsRepository get _repo => ref.read(reachUsRepoProvider);

    Future<void> fetchFaq({ required FetchFaqRequest request, }) async {
    state = const FetchFaqState.loading();
    final result = await _repo.fetchFaq(request: request);

    result.fold(
      (err) => state = FetchFaqState.failure(err.description ?? err.mwdesc ?? 'Server Error!'),
      (data) {
        state = FetchFaqState.success(data);
      },
    );
  }
}
