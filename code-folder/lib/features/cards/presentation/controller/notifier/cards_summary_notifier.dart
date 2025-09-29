import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entity/card_summary_entity.dart';
import '../../../domain/locator/cards_locator.dart';

part 'cards_summary_notifier.g.dart';

@riverpod
class GetCardSummary extends _$GetCardSummary {
  @override
  FutureOr<CardSummaryEntity> build() async {
    fetch();
    return future;
  }

  fetch({String field = "maskedCardNo", String type = "asc"}) async {
    state = const AsyncLoading();
    final data = await ref
        .read(cardsRepositoryLocatorProvider)
        .getCardSummary(field: field, type: type);
    state = data.fold(
          (l) => AsyncError(l.message, StackTrace.current),
          (r) => AsyncData(r),
    );
  }
}
