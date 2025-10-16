import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:dartz/dartz.dart';
import '../state/fetch_callback_fields_state.dart';
import '../../domain/repositories/reach_us_repository.dart';
import '../reach_us_providers.dart';
import '../../data/models/fetch_callback_fields_request.dart';

part 'fetch_callback_fields_notifier.g.dart';

@riverpod
class FetchCallbackFieldsNotifier extends _$FetchCallbackFieldsNotifier {
  @override
  FetchCallbackFieldsState build() => const FetchCallbackFieldsState.initial();

  ReachUsRepository get _repo => ref.read(reachUsRepoProvider);

    Future<void> fetchCallbackFields({ required FetchCallbackFieldsRequest request, }) async {
    state = const FetchCallbackFieldsState.loading();
    final result = await _repo.fetchCallbackFields(request: request);

    result.fold(
      (err) => state = FetchCallbackFieldsState.failure(err.description ?? err.mwdesc ?? 'Server Error!'),
      (data) {
        state = FetchCallbackFieldsState.success(data);
      },
    );
  }
}
