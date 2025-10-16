import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:dartz/dartz.dart';
import '../state/fetch_locate_us_info_state.dart';
import '../../domain/repositories/reach_us_repository.dart';
import '../reach_us_providers.dart';
import '../../data/models/fetch_locate_us_info_request.dart';

part 'fetch_locate_us_info_notifier.g.dart';

@riverpod
class FetchLocateUsInfoNotifier extends _$FetchLocateUsInfoNotifier {
  @override
  FetchLocateUsInfoState build() => const FetchLocateUsInfoState.initial();

  ReachUsRepository get _repo => ref.read(reachUsRepoProvider);

    Future<void> fetchLocateUsInfo({ required FetchLocateUsInfoRequest request, }) async {
    state = const FetchLocateUsInfoState.loading();
    final result = await _repo.fetchLocateUsInfo(request: request);

    result.fold(
      (err) => state = FetchLocateUsInfoState.failure(err.description ?? err.mwdesc ?? 'Server Error!'),
      (data) {
        state = FetchLocateUsInfoState.success(data);
      },
    );
  }
}
