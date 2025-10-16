import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:dartz/dartz.dart';
import '../state/fetch_call_back_request_state.dart';
import '../../domain/repositories/reach_us_repository.dart';
import '../reach_us_providers.dart';
import '../../data/models/fetch_call_back_request_request.dart';

part 'fetch_call_back_request_notifier.g.dart';

@riverpod
class FetchCallBackRequestNotifier extends _$FetchCallBackRequestNotifier {
  @override
  FetchCallBackRequestState build() => const FetchCallBackRequestState.initial();

  ReachUsRepository get _repo => ref.read(reachUsRepoProvider);

    Future<void> fetchCallBackRequest({ required FetchCallBackRequestRequest request, }) async {
    state = const FetchCallBackRequestState.loading();
    final result = await _repo.fetchCallBackRequest(request: request);

    result.fold(
      (err) => state = FetchCallBackRequestState.failure(err.description ?? err.mwdesc ?? 'Server Error!'),
      (data) {
        state = FetchCallBackRequestState.success(data);
      },
    );
  }
}
