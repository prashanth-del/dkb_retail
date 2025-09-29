
class UIBottomSheetModel {
  final String title;
  final List<BottomSheetModel> itemList;

  UIBottomSheetModel({
    required this.title,
    required this.itemList,
  });
}

class BottomSheetModel {
  final String name;
  final bool isSelected;

  BottomSheetModel({
    required this.name,
    required this.isSelected,
  });
}