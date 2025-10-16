import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../domain/locator/locate_us_locator.dart';

part 'locate_us_notifier.g.dart';

@riverpod
class LocateUsNotifier extends _$LocateUsNotifier {
  @override
  FutureOr<dynamic> build() async {
    await fetchLocateUs();
    return future;
  }

  Future<void> fetchLocateUs({
    String field = "bankType",
    String type = "asc",
  }) async {
    final result = await ref
        .read(locateUsRepositoryprovider)
        .getLocateEntity(requestBody: {});

    result.fold(
      (l) => state = AsyncError(l.message, StackTrace.current),
      (r) => state = AsyncData(r),
    );
  }
}

// class LocateUsNotifier extends _$LocateUsNotifier {
//   @override
//   FutureOr<dynamic> build() async {
//     await getLocateUs();
//     return future;
//   }
//
//   ReachUsRepository get _repository => ref.read(reachUsRepositoryprovider);
//
//   Future<void> getLocateUs() async {
//     ref.read(productsloadingProvider.notifier).state = true;
//     state = const AsyncLoading();
//     final failureOrSuccess = await _repository.getLocateUsDetails();
//
//     ref.read(productsloadingProvider.notifier).state =
//         false; // todo change this loading to locateUsLoading
//     state = failureOrSuccess.fold(
//       (l) => AsyncError(l.message, StackTrace.current),
//       (r) => AsyncData(r),
//     );
//   }
// }
