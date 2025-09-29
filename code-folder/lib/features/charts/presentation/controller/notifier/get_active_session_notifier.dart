import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../domain/entity/active_session_entity.dart';
import '../../../domain/entity/request/active_session_req.dart';
import '../../../domain/locator/dashboard_locator.dart';

part 'get_active_session_notifier.g.dart';

@riverpod
class GetActiveSessionNotifier extends _$GetActiveSessionNotifier {
  @override
  FutureOr<ActiveSessionEntity> build() {
    return future;
  }

  fetch(ActiveSessionReq req) async {
    state = const AsyncLoading();
    try {
      final failureOrSuccess = await ref.read(dashboardRepoProvider).getActiveSession(req);
      state = failureOrSuccess.fold(
            (error) {
          return AsyncError(error, StackTrace.current);
        },
            (data) {
          return AsyncData(data);
        },
      );
    } catch (e, stackTrace) {
      state = AsyncError(e, stackTrace);
    }
  }
}
