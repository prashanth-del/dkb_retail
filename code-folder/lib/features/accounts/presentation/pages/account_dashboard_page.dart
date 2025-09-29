import 'package:auto_route/auto_route.dart';
import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:db_uicomponents/src/components/ui_account_card_list.dart';
import 'package:db_uicomponents/src/components/ui_favorites_card.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/cache/global_cache.dart';
import '../../../../core/constants/asset_path/asset_path.dart';
import '../../../dashboard/presentation/widgets/widget_bottom_sheet.dart';
import '../../../home/presentation/provider/module_data_provider.dart';
import '../../data/model/account_selected_items.dart';
import '../../data/model/account_summary_model.dart';
import '../../domain/entity/account_summary_entity.dart';
import '../controller/account_list_provider.dart';
import '../controller/notifier/account_list_data.dart';
import '../controller/notifier/account_summary_notifier.dart';
import '../widget/dashboard_slider.dart';

class AccountsDashboardPage extends ConsumerStatefulWidget {
  const AccountsDashboardPage({super.key});

  @override
  ConsumerState<AccountsDashboardPage> createState() =>
      _AccountsDashboardPageState();
}

class _AccountsDashboardPageState extends ConsumerState<AccountsDashboardPage> {
  // int? _expandedIndex;
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final notifier = ref.read(reorderableListProvider.notifier);
      final futureList = ref.read(accountSelectedItemsProvider.future);
      notifier.loadList(futureList);
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  _buildSuccessPopup() async {
    return await UIPopupDialog().showPopup(
      viewModel: UIPopupViewModel(
        context: context,
        title: 'Changes Saved',
        titleStyle: const UiTextNew.h3Semibold("").getTextStyle(context),
        contentWidget: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/gif/complete.gif', height: 150.0, width: 150.0),
          ],
        ),
      ),
    );
  }

  _buildAddWidget() async {
    bool isNotEditable = ref.watch(isEditableProvider);
    ref.read(isEditableProvider.notifier).state = !isNotEditable;
    return await UIPopupDialog().showBottomSheet(
      context: context,
      child: const WidgetBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final reorderList = ref.watch(reorderableListProvider);

    for (var item in reorderList) {
      debugPrint(item.widgetType.toString());
    }

    return _buildContent(reorderList);
  }

  Widget _buildContent(List<AccountSelectedItems> listItems) {
    bool isNotEditable = ref.watch(isEditableProvider);
    listItems = listItems.where((item) => (item.isSelectedItem)).toList();
    if (listItems.isEmpty) {
      return const Center(child: UiLoader());
    }
    return SizedBox.expand(
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: Column(
                children: [
                  ref.watch(isEditableProvider)
                      ? UIListView<AccountSelectedItems>(
                          elements: listItems,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: UiCard(
                                cardColor: Colors.transparent,
                                borderColor: Colors.transparent,
                                child: listItems[index].getWidget(context),
                              ),
                            );
                          },
                        )
                      : ReorderableListView(
                          scrollController: _scrollController,
                          shrinkWrap: true,
                          onReorder: (oldIndex, newIndex) =>
                              _onReorder(oldIndex, newIndex),
                          children: listItems.map((item) {
                            return myOrderItem(item);
                          }).toList(),
                        ),
                ],
              ),
            ),
          ),
          if (!isNotEditable)
            Container(
              color: DefaultColors.white,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 15,
                  right: 15,
                  top: 10,
                  bottom: 10,
                ),
                child: UIScaleAnimation(
                  delay: 10,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: UIButton.rounded(
                          onPressed: () async {
                            await _buildAddWidget();
                          },
                          backgroundColor: DefaultColors.white_f3,
                          margin: EdgeInsets.zero,
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add,
                                color: DefaultColors.primaryBlue,
                                size: 20,
                              ),
                              UiTextNew.b2Semibold(
                                'ADD WIDGET',
                                color: DefaultColors.primaryBlue,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const UiSpace.horizontal(10),
                      Expanded(
                        flex: 1,
                        child: UIButton.rounded(
                          onPressed: () {
                            ref.read(isEditableProvider.notifier).state =
                                !isNotEditable;
                            _buildSuccessPopup();
                          },
                          backgroundColor: DefaultColors.primaryBlue,
                          margin: EdgeInsets.zero,
                          label: 'DONE',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget myOrderItem(AccountSelectedItems item) {
    return Stack(
      key: ValueKey(item.index),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Stack(
            children: [
              Column(
                children: [
                  const UiSpace.vertical(10),
                  UiCard(
                    shadowColor: DefaultColors.primaryGreen.withOpacity(0.2),
                    elevation: 10,
                    borderColor: DefaultColors.primaryGreen.withOpacity(0.3),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: item.getWidget(context),
                    ),
                  ),
                ],
              ),
              if (!item.isDefault)
                Positioned(
                  top: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () {
                      removeItemFromList(item);
                    },
                    child: const CircleAvatar(
                      radius: 12,
                      backgroundColor: DefaultColors.redDB,
                      child: Icon(Icons.remove, size: 12, color: Colors.white),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> removeItemFromList(AccountSelectedItems item) async {
    final globalCache = GlobalCache.instance;
    ref.read(reorderableListProvider.notifier).removeWidget(item);
    final updatedList = ref.read(reorderableListProvider);
    await globalCache.setAllAccountPageItems(updatedList);
    ref.refresh(accountSelectedItemsProvider);
  }

  Future<void> _onReorder(int oldIndex, int newIndex) async {
    final globalCache = GlobalCache.instance;
    ref.read(reorderableListProvider.notifier).reorder(oldIndex, newIndex);
    final updatedList = ref.read(reorderableListProvider);
    await globalCache.setAllAccountPageItems(updatedList);
    ref.refresh(accountSelectedItemsProvider);
  }
}
