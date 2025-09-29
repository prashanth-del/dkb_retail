import 'package:dkb_retail/features/reach_us/presentation/widgets/reason_sheet_widget.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/colors.dart';
import '../../../login/presentation/widgets/search_widget.dart';
import 'empty_widget.dart';
import 'more_sheet_widget.dart';

class SelectBranchSheetWidget extends StatefulWidget {
  final ValueChanged<String> serviceTypeSelected;
  final String? currentReason; // 👈 add this

  const SelectBranchSheetWidget({
    super.key,
    required this.serviceTypeSelected,
    this.currentReason,
  });

  @override
  State<SelectBranchSheetWidget> createState() =>
      _SelectBranchSheetWidgetState();
}

class _SelectBranchSheetWidgetState extends State<SelectBranchSheetWidget> {
  List<Map<String, dynamic>> selectTypeList = [
    {
      "title": "City Centre, Doha",
      "subTitle": "1.2km away  • Queue 12",
      "isSelected": false,
    },
    {
      "title": "Grand Hamad, Doha",
      "subTitle": "2km away  • Queue 14",
      "isSelected": false,
    },
    {
      "title": "Lagoona, Doha",
      "subTitle": "1.2km away  • Queue 12",
      "isSelected": false,
    },
    {
      "title": "Al Wakra, Doha",
      "subTitle": "3km away  • Queue 14",
      "isSelected": false,
    },
    {
      "title": "Al Sadd, Doha",
      "subTitle": "5km away  • Queue 16",
      "isSelected": false,
    },
    {
      "title": "Al Rayyan, Doha",
      "subTitle": "7.1km away  • Queue 16",
      "isSelected": false,
    },
    {
      "title": "Doha Festival City, Doha",
      "subTitle": "7.3km away  • Queue 17",
      "isSelected": false,
    },
    {
      "title": "Doha City, Doha",
      "subTitle": "7.3km away  • Queue 17",
      "isSelected": false,
    },
    {
      "title": "Festival, Doha",
      "subTitle": "7.3km away  • Queue 17",
      "isSelected": false,
    },
  ];

  late TextEditingController _searchController;
  late List<Map<String, dynamic>> filteredList;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    filteredList = List.from(selectTypeList);

    // Preselect current reason if provided
    if (widget.currentReason != null) {
      for (var element in selectTypeList) {
        element["isSelected"] = element["title"] == widget.currentReason;
      }
    }

    // Listen to search input changes
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      filteredList = selectTypeList
          .where((element) => element["title"].toLowerCase().contains(query))
          .toList();
    });
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return HeaderSheetWidget(
      titleSheet: "Select Branch",
      contentSheet: Column(
        // mainAxisSize: MainAxisSize.min, // 👈 important
        children: [
          SearchTextFilled(
            controller: _searchController,
            hintText: "Search for a Branch",
          ),
          const SizedBox(height: 32),
          filteredList.isNotEmpty
              ? Container(
                  // height: context.mediaQuery.size.height,
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    itemCount: filteredList.length,
                    separatorBuilder: (context, index) =>
                        Divider(color: DefaultColors.grayLightBase),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          // Unselect all
                          selectTypeList.forEach((element) {
                            element["isSelected"] = false;
                          });

                          // Select tapped
                          final selectedItem = filteredList[index];
                          selectedItem["isSelected"] = true;

                          widget.serviceTypeSelected(selectedItem["title"]);
                          Navigator.pop(context);
                          setState(() {});
                        },
                        child: ItemListWidget(
                          item: filteredList[index],
                          withSubTitle: true,
                        ),
                      );
                    },
                  ),
                )
              : EmptyWidget(),
        ],
      ),
    );
  }
}
