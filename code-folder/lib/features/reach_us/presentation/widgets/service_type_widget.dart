import 'package:dkb_retail/features/reach_us/presentation/widgets/reason_sheet_widget.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/colors.dart';
import 'more_sheet_widget.dart';

class SelectTypeSheetWidget extends StatefulWidget {
  final ValueChanged<String> serviceTypeSelected;
  final String? currentReason; // 👈 add this

  const SelectTypeSheetWidget({
    super.key,
    required this.serviceTypeSelected,
    this.currentReason,
  });

  @override
  State<SelectTypeSheetWidget> createState() => _SelectTypeSheetWidgetState();
}

class _SelectTypeSheetWidgetState extends State<SelectTypeSheetWidget> {
  List<Map<String, dynamic>> selectTypeList = [
    {"title": "Savings Account", "isSelected": false},
    {"title": "Current Account", "isSelected": false},
    {"title": "Credit Card", "isSelected": false},
  ];
  @override
  void initState() {
    super.initState();
    if (widget.currentReason != null) {
      for (var element in selectTypeList) {
        element["isSelected"] = element["title"] == widget.currentReason;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return HeaderSheetWidget(
      titleSheet: "Select Service Type",
      contentSheet: ListView.separated(
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              selectTypeList.forEach((element) {
                if (element["isSelected"]) {
                  element["isSelected"] = false;
                }
              });
              selectTypeList[index]["isSelected"] = true;
              widget.serviceTypeSelected(selectTypeList[index]["title"]);
              Navigator.pop(context);
              setState(() {});
            },
            child: ItemListWidget(
              item: selectTypeList[index],
              withSubTitle: false,
            ),
          );
        },
        separatorBuilder: (context, index) =>
            Divider(color: DefaultColors.grayLightBase),
        itemCount: selectTypeList.length,
      ),
    );
  }
}
