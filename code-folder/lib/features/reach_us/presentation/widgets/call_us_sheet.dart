import 'package:db_uicomponents/components.dart';
import 'package:db_uicomponents/utils.dart';
import 'package:dkb_retail/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controller/reach_us_providers.dart';
import 'custom_button.dart';

class CallUsSheet extends ConsumerStatefulWidget {
  const CallUsSheet({super.key});

  @override
  ConsumerState<CallUsSheet> createState() => _CallUsSheetState();
}

class _CallUsSheetState extends ConsumerState<CallUsSheet> {
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
    final bankDetails = ref.read(reachUsNotifierProvider).bankDetails;
    print(";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;");
    print(bankDetails);
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
                  _makePhoneCall("${bankDetails!.contact!}");
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 13),
                  child: UiTextNew.customRubik(
                    "${bankDetails!.contact} (Local)",
                    color: DefaultColors.blue,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              Divider(color: DefaultColors.grayBase, thickness: 0, height: 0),

              GestureDetector(
                onTap: () {
                  _makePhoneCall("${bankDetails!.internationalContact}");
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 13),
                  child: UiTextNew.customRubik(
                    "${bankDetails!.internationalContact} (Overseas)",
                    color: DefaultColors.blue,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
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
          titleColor: DefaultColors.blue,
          buttonColor: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
        SizedBox(height: 8),
      ],
    );
  }
}
