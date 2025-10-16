import 'package:db_uicomponents/components.dart';
import 'package:dkb_retail/core/constants/colors.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_strings/default_string.dart';
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
      titleSheet: DefaultString.instance.selectReason,
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

class FieldSheetWidget extends StatefulWidget {
  final String titleSheet;
  final ValueChanged<String> itemSelected;
  final String? controllerText;
  final List<dynamic> options; // ✅ dynamic options from API

  const FieldSheetWidget({
    super.key,
    required this.itemSelected,
    required this.options, // ✅ required list
    this.controllerText,
    required this.titleSheet,
  });

  @override
  State<FieldSheetWidget> createState() => _FieldSheetWidgetState();
}

class _FieldSheetWidgetState extends State<FieldSheetWidget> {
  late List<Map<String, dynamic>> reasonList;

  @override
  void initState() {
    super.initState();

    // ✅ Convert string list to your internal structure
    reasonList = widget.options
        .map(
          (e) => {
            "title": e,
            "isSelected": e == widget.controllerText, // pre-select
          },
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return HeaderSheetWidget(
      withCloseIcon: false,
      titleSheet: widget.titleSheet,
      contentSheet: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListView.separated(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    for (var item in reasonList) {
                      item["isSelected"] = false;
                    }
                    reasonList[index]["isSelected"] = true;
                  });

                  widget.itemSelected(reasonList[index]["title"]);
                  Navigator.pop(context);
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
      color: Colors.transparent,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 13),
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
