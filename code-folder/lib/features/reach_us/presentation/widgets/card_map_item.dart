import 'package:db_uicomponents/components.dart';
import 'package:dkb_retail/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/constants/app_strings/default_string.dart';
import '../../../../core/constants/asset_path/asset_path.dart';
import '../../../common/presentation/dialog/custom_sheet.dart';
import 'filter_sheet.dart';

class ItemListWidget extends StatefulWidget {
  final bool isSelected;
  final Map<String, dynamic> loc;
  final String addressText;
  const ItemListWidget({
    super.key,
    required this.loc,
    required this.isSelected,
    required this.addressText,
  });

  @override
  State<ItemListWidget> createState() => _ItemListWidgetState();
}

class _ItemListWidgetState extends State<ItemListWidget> {
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
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: widget.isSelected ? Colors.blue.shade50 : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: widget.isSelected ? Colors.blue : Colors.grey.shade300,
          width: 2,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                CustomSheet.show(
                  context: context,
                  child: ItemSearchSheet(item: widget.loc),
                );
              },
              child: Row(
                children: [
                  Image.asset(
                    AssetPath.image.branchDefaultImage,
                    width: 92,
                    height: 92,
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          UiTextNew.customRubik(
                            widget.loc["id"],
                            color: DefaultColors.grayBase,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: UiTextNew.customRubik(
                              " . ",
                              color: DefaultColors.grayBase,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          UiTextNew.customRubik(
                            widget.loc["status"],
                            color: DefaultColors.greenBase,
                            fontSize: 14,
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Container(
                        width: 129,
                        child: UiTextNew.customRubik(
                          widget.loc["name"],
                          fontWeight: FontWeight.w800,
                          fontSize: 12,
                          maxLines: 1,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        width: 129,
                        child: UiTextNew.customRubik(
                          "${widget.loc["address"] ?? "${widget.loc["name"]}"}, ${widget.loc["country"] ?? ""}",
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(height: 4),
                      UiTextNew.customRubik(
                        widget.loc["isNearest"]
                            ? DefaultString.instance.nearestTitle
                            : "",

                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 20),
            GestureDetector(
              onTap: () {
                _openMap(
                  query: widget.addressText,
                  lat: widget.loc["lat"],
                  lng: widget.loc["long"],
                );
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    AssetPath.image.navigationImage,
                    width: 32,
                    height: 32,
                  ),
                  const SizedBox(height: 2),
                  UiTextNew.custom(
                    DefaultString.instance.direction,
                    fontWeight: FontWeight.w500,
                    fontSize: 11,
                    color: DefaultColors.blueLightBase,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
