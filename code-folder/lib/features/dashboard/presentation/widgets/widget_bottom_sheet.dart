import 'package:db_uicomponents/components.dart';
import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/cache/global_cache.dart';
import '../../../accounts/data/model/account_selected_items.dart';
import '../../../accounts/presentation/controller/account_list_provider.dart';
import '../../../accounts/presentation/controller/notifier/account_list_data.dart';

class WidgetBottomSheet extends ConsumerStatefulWidget {

  const WidgetBottomSheet({super.key});

  @override
  ConsumerState<WidgetBottomSheet> createState() => _WidgetBottomSheetState();
}

class _WidgetBottomSheetState extends ConsumerState<WidgetBottomSheet> {
  @override
  void initState() {
    super.initState();
  }

  Widget _buildHeader() {
    return ListTile(
      contentPadding: const EdgeInsets.only(right: 10, left: 20, top: 5),
      hoverColor: DefaultColors.transparent,
      splashColor: DefaultColors.transparent,
      focusColor: DefaultColors.transparent,
      style: ListTileStyle.list,
      dense: true,
      title: const UiTextNew.h3Semibold("Select Widget"),
      trailing: UIIconContainer(
        icon: Icons.close,
        color: DefaultColors.transparent,
        iconColor: DefaultColors.gray8A,
        onTap: () => Navigator.of(context).pop(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildHeader(),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 17),
          child: Divider(color: DefaultColors.blue_02),
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: SizedBox(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: _buildItemList(),
              ),
            ),
          ),
        )
      ],
    );
  }

  List<Widget> _buildItemList() {
    List listItems = ref.watch(accountListProvider);
    listItems = listItems.where((item) => (!item.isDefault)).toList();
    return List.generate(listItems.length, (index) {
      final AccountSelectedItems item = listItems[index];
      return Consumer(
        builder: (context, ref, child) {
          final accountItemsAsync = ref.watch(accountSelectedItemsProvider);
          return accountItemsAsync.when(
            data: (items) {
              int reorderIndex = items.indexWhere((reorderItem) => reorderItem.widgetType == item.widgetType);
              if(reorderIndex != -1) {
                bool isSelected = items[reorderIndex].isSelectedItem;
                return _buildListItem(item, index, isSelected);
              }
              return const SizedBox.shrink();
            },
            loading: () => const CircularProgressIndicator(),
            error: (error, stackTrace) => Text('Error: $error'),
          );
        },
      );
    });
  }

  Widget _buildListItem(AccountSelectedItems item, int index, bool isSelected) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: UiCard(
        shadowColor: DefaultColors.primaryGreen.withOpacity(0.2),
        elevation: 10,
        borderColor: DefaultColors.primaryGreen.withOpacity(0.3),
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        child: Column(
          children: [
            ListTile(
              title: UiTextNew.customRubik(
                item.editTitle,
                fontSize: 15,
                color: DefaultColors.primaryBlue,
                fontWeight: FontWeight.bold,
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 10),
              trailing: ElevatedButton.icon(
                icon: Icon(
                  !isSelected ? Icons.add : Icons.remove,
                  color: DefaultColors.white,
                  size: 15,
                ),
                onPressed: () {
                  !isSelected
                      ? onAddWidget(item)
                      : onRemoveWidget(item);
                },
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.only(
                        top: 2, left: 10, bottom: 2, right: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    backgroundColor: isSelected
                        ? DefaultColors.redDB
                        : DefaultColors.blue9D),
                label: Text(
                  !isSelected ? 'Add Widget' : 'Remove',
                  style: const TextStyle(fontSize: 12, color: DefaultColors.white),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
              child: Column(children: [
                item.getWidget(context),
                const SizedBox(
                  height: 20,
                )
              ]),
            )
          ],
        ),
      ),
    );
  }

  void onAddWidget(AccountSelectedItems item) async {
    final globalCache = GlobalCache.instance;
    ref.read(reorderableListProvider.notifier).addWidget(item);
    final updatedList = ref.read(reorderableListProvider);
    for (var item in updatedList) {
      debugPrint(item.widgetType.toString());
    }
    await globalCache.setAllAccountPageItems(updatedList);
    ref.refresh(accountSelectedItemsProvider);
    Navigator.pop(context);
    showSuccessAlert(context);
  }

  void onRemoveWidget(AccountSelectedItems item) async {
    final globalCache = GlobalCache.instance;
    ref.read(reorderableListProvider.notifier).removeWidget(item);
    final updatedList = ref.read(reorderableListProvider);
    await globalCache.setAllAccountPageItems(updatedList);
    ref.refresh(accountSelectedItemsProvider);
    Navigator.pop(context);
    showSuccessAlert(context);
  }

  void showSuccessAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        // Schedule a delayed dismissal of the alert dialog after 3 seconds
        Future.delayed(const Duration(seconds: 3), () {
          if(mounted) Navigator.of(context).pop(); // Close the dialog
        });
        // Return the AlertDialog widget
        return AlertDialog(
          contentPadding: const EdgeInsets.all(15),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/gif/complete.gif',
                height: 80.0,
                width: 80.0,
              ),
              const SizedBox(height: 10),
              const UiTextNew.customRubik(
                'Changes Saved !',
                color: DefaultColors.blue9D,
                fontSize: 18,
                textAlign: TextAlign.center,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
        );
      },
    );
  }
}
