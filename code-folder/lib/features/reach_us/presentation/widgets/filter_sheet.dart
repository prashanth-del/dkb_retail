import 'package:auto_route/auto_route.dart';
import 'package:db_uicomponents/components.dart';
import 'package:dkb_retail/core/constants/colors.dart';
import 'package:dkb_retail/core/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/constants/app_strings/default_string.dart';
import '../../../../core/constants/asset_path/asset_path.dart';
import '../controller/reach_us_providers.dart';
import 'custom_button.dart';
import 'more_sheet_widget.dart';

class FilterSheet extends ConsumerStatefulWidget {
  final int selectedTabIndex; // 1 = Branches, 2 = ATMs, 3 = Kiosks
  final int selectedIndex; // current selection for this tab
  const FilterSheet({
    Key? key,
    required this.selectedTabIndex,
    required this.selectedIndex,
  }) : super(key: key);

  @override
  ConsumerState<FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends ConsumerState<FilterSheet> {
  late List<Map<String, dynamic>> list;
  String? title;

  @override
  void initState() {
    super.initState();
    final reachUsState = ref.read(reachUsNotifierProvider); // ✅ correct
    // or ref.watch in consumer

    if (widget.selectedTabIndex == 1) {
      // ✅ BRANCHES
      list = [
        {"title": DefaultString.instance.allBranchesTitle, "isSelected": false},
        {"title": DefaultString.instance.nearestTitle, "isSelected": false},
        ...reachUsState.branches.map(
          (b) => {"title": b.fullAddress!.trim(), "isSelected": false},
        ),
      ];
      title = title = DefaultString.instance.branches;
    } else if (widget.selectedTabIndex == 2) {
      // ✅ ATMS
      bool hasCashDeposit = reachUsState.atms.any((a) => a.cashDeposit == 1);
      bool hasCashOut = reachUsState.atms.any((a) => a.cashOut == 1);
      bool hasChequeDeposit = reachUsState.atms.any(
        (a) => a.chequeDeposit == 1,
      );
      bool hasSpecialNeeds = reachUsState.atms.any((a) => a.disablePeople == 1);

      list = [
        {"title": DefaultString.instance.allAtmsTitle, "isSelected": false},
        {"title": DefaultString.instance.nearestTitle, "isSelected": false},
        if (hasCashDeposit)
          {
            "title": DefaultString.instance.cashDepositTitle,
            "isSelected": false,
          },
        if (hasCashOut)
          {
            "title": DefaultString.instance.cashWithdrawalsTitle,
            "isSelected": false,
          },
        if (hasChequeDeposit)
          {
            "title": DefaultString.instance.chequeDepositTitle,
            "isSelected": false,
          },
        if (hasSpecialNeeds)
          {
            "title": DefaultString.instance.specialNeedsTitle,
            "isSelected": false,
          },
      ];
      title = title = DefaultString.instance.atms;
    } else {
      // ✅ KIOSKS
      list = [
        {"title": DefaultString.instance.allKiosksTitle, "isSelected": false},
        {"title": DefaultString.instance.nearestTitle, "isSelected": false},
      ];
      title = DefaultString.instance.kiosks;
    }

    // ✅ Apply previous selected index
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
                    color: (index != list.length - 1)
                        ? DefaultColors.grayLightBase
                        : Colors.transparent,
                    width: 1,
                  ),
                ),
                //  color: Colors.white,
              ),
              padding: const EdgeInsets.symmetric(vertical: 13),
              child: UiTextNew.customRubik(
                list[index]["title"],
                fontSize: 13,
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
  final Map<String, dynamic> item;
  const ItemSearchSheet({super.key, required this.item});

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
    String raw = widget.item["workingHours"] ?? "";
    String formatted = raw.replaceAll(r'\n', '\n');
    return HeaderSheetWidget(
      withCloseIcon: false,
      contentSheet: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              AssetPath.image.branchDefaultImage, // change later
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
                    "${widget.item["name"]}",
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                  ),
                  SizedBox(height: 4),
                  UiTextNew.customRubik(
                    "${widget.item["address"] ?? "${widget.item["name"]}"}, ${widget.item["country"] ?? ""}",
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                  SizedBox(height: 4),
                  UiTextNew.customRubik(
                    widget.item["isNearest"]
                        ? DefaultString.instance.nearestTitle
                        : "",
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),

              GestureDetector(
                onTap: () {
                  print(";;;;;;;;;;;;;;;;;;;;;;;;;;;");
                  _openMap(
                    query: "${widget.item["name"]}",
                    lng: widget.item["long"],
                    lat: widget.item["lat"],
                  );
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              UiTextNew.customRubik(
                DefaultString.instance.operationHours,
                color: DefaultColors.grayBase,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
              UiTextNew.customRubik(
                formatted,
                // getOperatingHours(widget.item, widget.item["type"]),
                // "Sunday to Thursday, 7:30am - 1:00pm",
                color: DefaultColors.grayBase,
                fontWeight: FontWeight.w500,
                fontSize: 12,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 20),
              widget.item["type"] == "Branch"
                  ? CustomButtonNewWidget(
                      title: DefaultString.instance.bookAndMeetTitle,
                      onPress: () {
                        context.router.push(BookAndMeetPageRoute());
                      },
                    )
                  : SizedBox(),
            ],
          ),
          // : UiTextNew.customRubik(
          //     "Open 24/7",
          //     fontWeight: FontWeight.w800,
          //     fontSize: 14,
          //   ),
          SizedBox(height: 12),
        ],
      ),
    );
  }
}
