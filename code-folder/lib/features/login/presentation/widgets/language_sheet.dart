import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:flutter/material.dart';

import '../../../../core/cache/global_cache.dart';
import 'language_sheet_model.dart';

class LanguageBottomSheet extends StatefulWidget {
  final LanguageSheetModel languageSheetModel;

  const LanguageBottomSheet({super.key, required this.languageSheetModel});

  @override
  State<LanguageBottomSheet> createState() => _LanguageBottomSheet();
}

class _LanguageBottomSheet extends State<LanguageBottomSheet> {
  final ShapeBorder _tileShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(8),
    side: BorderSide(color: DefaultColors.primaryBlue.withOpacity(0.2)),
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildHeader(),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 17),
          child: Divider(color: DefaultColors.blue_02),
        ),
        const UiSpace.vertical(5),
        ..._buildItemList(),
      ],
    );
  }

  /// Builds the header of the bottom sheet, including the title and close button
  Widget _buildHeader() {
    return ListTile(
      contentPadding: const EdgeInsets.only(right: 10, left: 20, top: 5),
      hoverColor: DefaultColors.transparent,
      splashColor: DefaultColors.transparent,
      focusColor: DefaultColors.transparent,
      style: ListTileStyle.list,
      dense: true,
      title: UiTextNew.h3Semibold(widget.languageSheetModel.title),
      trailing: UIIconContainer(
        icon: Icons.close,
        color: DefaultColors.transparent,
        iconColor: DefaultColors.gray8A,
        onTap: () => Navigator.of(context).pop(),
      ),
    );
  }

  /// Builds the list of items in the bottom sheet
  List<Widget> _buildItemList() {
    return List.generate(widget.languageSheetModel.itemList.length, (index) {
      final LangBottomSheetModel item =
          widget.languageSheetModel.itemList[index];
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: _buildListItem(item, index),
      );
    });
  }

  /// Builds a single list item
  Widget _buildListItem(LangBottomSheetModel item, int index) {
    return ListTile(
      onTap: () async {
        // await GlobalCache.instance.setSelectedLangFlag(item.image);
        Navigator.of(context).pop(item);
      },
      contentPadding: const EdgeInsets.symmetric(horizontal: 10),
      dense: true,
      visualDensity: const VisualDensity(vertical: -2),
      minVerticalPadding: 0,
      tileColor: item.isSelected
          ? DefaultColors.primaryBlue
          : DefaultColors.transparent,
      shape: _tileShape,
      leading: Image.asset(
        item.image,
        width: 30,
        height: 30,
      ),
      title: UiTextNew.b1Semibold(
        item.name,
        color: item.isSelected ? DefaultColors.white : null,
      ),
    );
  }
}
