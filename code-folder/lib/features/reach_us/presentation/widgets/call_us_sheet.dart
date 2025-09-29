import 'package:db_uicomponents/components.dart';
import 'package:db_uicomponents/utils.dart';
import 'package:dkb_retail/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'custom_button.dart';

class CallUsSheet extends StatefulWidget {
  const CallUsSheet({super.key});

  @override
  State<CallUsSheet> createState() => _CallUsSheetState();
}

class _CallUsSheetState extends State<CallUsSheet> {
  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      throw 'Could not launch $phoneNumber';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: context.screenWidth - 14,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: DefaultColors.grayLightBase,
          ),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  _makePhoneCall("+9748008555");
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 13),
                  child: UiTextNew.customRubik(
                    "+974 800 8555 (Local)",
                    color: DefaultColors.blueLightBase,
                    fontSize: 14,
                  ),
                ),
              ),

              Divider(color: DefaultColors.grayBase, thickness: 0, height: 0),

              GestureDetector(
                onTap: () {
                  _makePhoneCall("+974 4410 0888");
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 13),
                  child: UiTextNew.customRubik(
                    "+974 4410 0888 (Overseas)",
                    color: DefaultColors.blueLightBase,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8),
        CustomButtonNewWidget(
          radius: 12,
          onPress: () {
            Navigator.pop(context);
          },
          title: "Cancel",
          titleColor: DefaultColors.blueLightBase,
          buttonColor: Colors.white,
        ),
        SizedBox(height: 8),
      ],
    );
  }
}
