import 'package:db_uicomponents/components.dart';
import 'package:dkb_retail/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/constants/asset_path/asset_path.dart';
import 'custom_button.dart';
import 'more_sheet_widget.dart';

class FilterSheet extends StatefulWidget {
  final int selectedTabIndex; // 1 = Branches, 2 = ATMs, 3 = Kiosks
  final int selectedIndex; // current selection for this tab

  const FilterSheet({
    Key? key,
    required this.selectedTabIndex,
    required this.selectedIndex,
  }) : super(key: key);

  @override
  State<FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends State<FilterSheet> {
  late List<Map<String, dynamic>> list;
  String? title;

  @override
  void initState() {
    super.initState();

    if (widget.selectedTabIndex == 1) {
      list = [
        {"title": "All Branches", "isSelected": false},
        {"title": "Nearest", "isSelected": false},
        {"title": "Grand Hamad Street", "isSelected": false},
        {"title": "Al Rayyan Branch", "isSelected": false},
        {"title": "City Centre Branch", "isSelected": false},
        {"title": "Doha Festival City Branch", "isSelected": false},
        {"title": "Lagoona Branch", "isSelected": false},
        {"title": "Al Wakra Branch", "isSelected": false},
        {"title": "Qatar Airways Branch", "isSelected": false},
      ];
      title = "Branches";
    } else if (widget.selectedTabIndex == 2) {
      list = [
        {"title": "All ATMs", "isSelected": false},
        {"title": "Nearest", "isSelected": false},
        {"title": "Cash Deposits", "isSelected": false},
        {"title": "Cash Withdrawls", "isSelected": false},
        {"title": "Cheque Deposits", "isSelected": false},
        {"title": "Special Needs", "isSelected": false},
      ];
      title = "ATMs";
    } else {
      list = [
        {"title": "All Kiosk", "isSelected": false},
        {"title": "Nearest", "isSelected": false},
      ];
      title = "Kiosks";
    }

    // ✅ apply selection for this tab only
    if (widget.selectedIndex >= 0 && widget.selectedIndex < list.length) {
      list[widget.selectedIndex]["isSelected"] = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return HeaderSheetWidget(
      withCloseIcon: false,
      titleSheet: title,
      contentSheet: ListView.builder(
        shrinkWrap: true,
        itemCount: list.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // ✅ clear old selection
              for (var element in list) {
                element["isSelected"] = false;
              }
              list[index]["isSelected"] = true;
              setState(() {});

              // ✅ return new index to parent
              Navigator.pop(context, index);
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: DefaultColors.grayLightBase,
                    width: 1,
                  ),
                ),
                //  color: Colors.white,
              ),
              padding: const EdgeInsets.symmetric(vertical: 13),
              child: UiTextNew.customRubik(
                list[index]["title"],
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: list[index]["isSelected"]
                    ? DefaultColors.blueLightBase
                    : Colors.black,
              ),
            ),
          );
        },
      ),
    );
  }
}

class ItemSearchSheet extends StatefulWidget {
  final String typeSearch;
  const ItemSearchSheet({super.key, required this.typeSearch});

  @override
  State<ItemSearchSheet> createState() => _ItemSearchSheetState();
}

class _ItemSearchSheetState extends State<ItemSearchSheet> {
  Future<void> _openMap({double? lat, double? lng, String? query}) async {
    Uri googleUrl;

    if (lat != null && lng != null) {
      googleUrl = Uri.parse(
        "https://www.google.com/maps/search/?api=1&query=$lat,$lng",
      );
    } else if (query != null) {
      googleUrl = Uri.parse(
        "https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(query)}",
      );
    } else {
      throw 'No location data provided';
    }

    if (await canLaunchUrl(googleUrl)) {
      await launchUrl(googleUrl, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not open the map.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return HeaderSheetWidget(
      withCloseIcon: false,
      contentSheet: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),

            child: Image.asset(
              AssetPath.image.branchDefaultImage,
              width: double.infinity,
              height: 185,
              fit: BoxFit.fitWidth,
            ),
          ),
          SizedBox(height: 24),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  UiTextNew.customRubik(
                    "City Center, Doha",
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                  ),
                  SizedBox(height: 4),
                  UiTextNew.customRubik(
                    "Industrial Area, Qatar",
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                  SizedBox(height: 4),
                  UiTextNew.customRubik(
                    "Nearest",
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),

              GestureDetector(
                onTap: () {
                  print(";;;;;;;;;;;;;;;;;;;;;;;;;;;");
                  _openMap(query: "Doha, Qatar");
                },
                child: Center(
                  child: Image.asset(
                    AssetPath.image.navigationImage,
                    width: 32,
                    height: 32,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 24),
          widget.typeSearch == "branch"
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    UiTextNew.customRubik(
                      "Operation Hours",
                      color: DefaultColors.grayBase,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                    UiTextNew.customRubik(
                      "Sunday to Thursday, 7:30am - 1:00pm",
                      color: DefaultColors.grayBase,
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    ),
                    SizedBox(height: 20),
                    CustomButtonNewWidget(
                      title: "Book and Meet",
                      onPress: () {},
                    ),
                  ],
                )
              : UiTextNew.customRubik(
                  "Open 24/7",
                  fontWeight: FontWeight.w800,
                  fontSize: 14,
                ),
          SizedBox(height: 12),
        ],
      ),
    );
  }
}
