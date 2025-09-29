import 'package:dkb_retail/features/accounts/data/model/account_selected_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReorderableListNotifier
    extends StateNotifier<List<AccountSelectedItems>> {
  ReorderableListNotifier() : super([]);

  // Load initial data
  Future<void> loadList(Future<List<AccountSelectedItems>> futureList) async {
    state = await futureList;
  }

  // Reorder the list
  void reorder(int oldIndex, int newIndex) {
    debugPrint(oldIndex.toString());
    debugPrint(newIndex.toString());
    final list = [...state]; // Create a copy of the list
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final item = list.removeAt(oldIndex);
    list.insert(newIndex, item);
    state = list; // Update state
  }

  void addWidget(AccountSelectedItems accItem) {
    final list = [...state];
    int index = list.indexWhere(
      (item) => item.widgetType == accItem.widgetType,
    );
    // list.insert(index, item);

    debugPrint(index.toString());
    if (index != -1) {
      // Update the object directly
      list[index].isSelectedItem = true;
    }
    state = list; // Update state
  }

  void removeWidget(AccountSelectedItems accItem) {
    final list = [...state];
    int index = list.indexWhere(
      (item) => item.widgetType == accItem.widgetType,
    );
    // list.insert(index, item);

    debugPrint(index.toString());
    if (index != -1) {
      // Update the object directly
      list[index].isSelectedItem = false;
    }
    state = list; // Update state
  }
}
