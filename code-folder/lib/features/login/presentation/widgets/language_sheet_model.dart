class LanguageSheetModel {
  final String title;
  final List<LangBottomSheetModel> itemList;

  LanguageSheetModel({
    required this.title,
    required this.itemList,
  });
}

class LangBottomSheetModel {
  final int index;
  final String name;
  final String image;
  final bool isSelected;

  LangBottomSheetModel({
    required this.index,
    required this.name,
    required this.image,
    required this.isSelected,
  });
}
