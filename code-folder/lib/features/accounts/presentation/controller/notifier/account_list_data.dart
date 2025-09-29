import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/cache/global_cache.dart';
import '../../../data/model/account_selected_items.dart';

final accountListProvider = Provider<List<AccountSelectedItems>>((ref) {
  return [
    AccountSelectedItems(
        index: 1,
        id: 2,
        isSelectedItem: true,
        isDefault: false,
        widgetType: 'FavouritesDashCard',
        editTitle: ''),
    AccountSelectedItems(
        index: 2,
        id: 3,
        isSelectedItem: true,
        isDefault: false,
        widgetType: 'InstaTransfersCard',
        editTitle: ''),
    AccountSelectedItems(
        index: 3,
        id: 4,
        isSelectedItem: true,
        isDefault: false,
        widgetType: 'PayBill',
        editTitle: ''),
    AccountSelectedItems(
        index: 4,
        id: 5,
        isSelectedItem: true,
        isDefault: false,
        widgetType: 'SuggestedSection',
        editTitle: 'Suggestions'),
    AccountSelectedItems(
        index: 5,
        id: 6,
        isSelectedItem: false,
        isDefault: false,
        widgetType: 'Offers',
        editTitle: 'Offers'),
    AccountSelectedItems(
        index: 6,
        id: 7,
        isSelectedItem: true,
        isDefault: false,
        widgetType: 'BrandDeals',
        editTitle: 'Brand Deals'),
    AccountSelectedItems(
        index: 7,
        id: 8,
        isSelectedItem: true,
        isDefault: false,
        widgetType: 'SavingsAndInvestments',
        editTitle: 'Investment Quick Links'),
    AccountSelectedItems(
        index: 8,
        id: 9,
        isSelectedItem: false,
        isDefault: false,
        widgetType: 'TravelPackages',
        editTitle: 'Travel Packages'),
    AccountSelectedItems(
        index: 9,
        id: 10,
        isSelectedItem: false,
        isDefault: false,
        widgetType: 'TravelQuickLinks',
        editTitle: 'Travel Quick Links'),
    AccountSelectedItems(
        index: 10,
        id: 11,
        isSelectedItem: false,
        isDefault: false,
        widgetType: 'PersonalisedDeals',
        editTitle: 'Personalised Deals'),
  ];
});

final accountSelectedItemsProvider =
    FutureProvider<List<AccountSelectedItems>>((ref) async {
  final globalCache = GlobalCache.instance;

  // Check if the cache has the all account page items list
  List<AccountSelectedItems> allItems = await globalCache.getAllAccountPageItems();

  if (allItems.isEmpty) {
    final defaultList = ref.read(accountListProvider);
    allItems.addAll(defaultList);
    allItems.insert(
      0,
      AccountSelectedItems(
        index: 0,
        id: 1,
        isSelectedItem: true,
        isDefault: true,
        editTitle: '',
        widgetType: 'AccountInfoCard', // A reusable widget
      ),
    );
  }

  return allItems;
});
