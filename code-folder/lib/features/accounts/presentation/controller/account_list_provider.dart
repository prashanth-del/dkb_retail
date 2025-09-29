import 'package:dkb_retail/features/accounts/data/model/account_selected_items.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'notifier/ReorderableListNotifier.dart';
import 'notifier/account_list_data.dart';

final accountListDataProvider =
    StateProvider<List<AccountSelectedItems>>((ref) {
  final moduleDashMap = ref.watch(accountListProvider);
  return moduleDashMap.toList();
});

final reorderableListProvider =
    StateNotifierProvider<ReorderableListNotifier, List<AccountSelectedItems>>(
  (ref) => ReorderableListNotifier(),
);
