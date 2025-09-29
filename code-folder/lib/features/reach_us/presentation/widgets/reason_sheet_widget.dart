import 'package:db_uicomponents/components.dart';
import 'package:dkb_retail/core/constants/colors.dart';
import 'package:flutter/material.dart';

import 'more_sheet_widget.dart';

class ReasonSheetWidget extends StatefulWidget {
  final ValueChanged<String> reasonSelected;
  final String? currentReason; // 👈 add this

  const ReasonSheetWidget({
    super.key,
    required this.reasonSelected,
    this.currentReason,
  });

  @override
  State<ReasonSheetWidget> createState() => _ReasonSheetWidgetState();
}

class _ReasonSheetWidgetState extends State<ReasonSheetWidget> {
  List<Map<String, dynamic>> reasonList = [
    {"title": "Account Related", "isSelected": false},
    {"title": "Card Related", "isSelected": false},
    {"title": "test Related", "isSelected": false},
  ];
  @override
  void initState() {
    super.initState();
    if (widget.currentReason != null) {
      for (var element in reasonList) {
        element["isSelected"] = element["title"] == widget.currentReason;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return HeaderSheetWidget(
      withCloseIcon: false,
      titleSheet: "Select Reason",
      contentSheet: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListView.separated(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  reasonList.forEach((element) {
                    if (element["isSelected"]) {
                      element["isSelected"] = false;
                    }
                  });
                  reasonList[index]["isSelected"] = true;
                  widget.reasonSelected(reasonList[index]["title"]);
                  Navigator.pop(context);
                  setState(() {});
                },
                child: ItemListWidget(
                  item: reasonList[index],
                  withSubTitle: false,
                ),
              );
            },
            separatorBuilder: (context, index) =>
                Divider(color: DefaultColors.grayLightBase),
            itemCount: reasonList.length,
          ),
        ],
      ),
    );
  }
}

class ItemListWidget extends StatelessWidget {
  final Map<String, dynamic> item;
  final bool withSubTitle;
  const ItemListWidget({
    super.key,
    required this.item,
    required this.withSubTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            UiTextNew.customRubik(
              item["title"],
              fontSize: 12,
              color: item["isSelected"]
                  ? DefaultColors.blueBase
                  : DefaultColors.black,
            ),
            withSubTitle
                ? UiTextNew.customRubik(
                    item["subTitle"],
                    fontSize: 11,
                    color: item["isSelected"]
                        ? DefaultColors.blueBase
                        : DefaultColors.grayBase,
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}
