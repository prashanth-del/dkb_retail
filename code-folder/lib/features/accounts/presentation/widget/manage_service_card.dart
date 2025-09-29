
import 'package:db_uicomponents/components.dart';
import 'package:db_uicomponents/src/components/managesSlider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/asset_path/asset_path.dart';
import '../../../../core/constants/colors.dart';
import 'bottomWidget.dart';
import 'donaload_bottomsheet.dart';
import 'eiban_bottomsheet.dart';

class ManageServiceCardCard extends StatelessWidget {
  const ManageServiceCardCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ManageCard(
      names: ['Download Statement', 'eIBAN Certificate', 'Request Cheque Book', 'Manage E-STATEMENT'],
      icons: [
        UISvgIcon(
            assetPath: AssetPath.icon.download,
            color: DefaultColors.blue9D,
        onTap: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            builder: (BuildContext context) {
              return Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ), // Ensures the sheet is not covered by the keyboard
                child: DownloadStatementBottomSheet(),
              );
            },
          );
        },
        ),
        UISvgIcon(
            assetPath: AssetPath.icon.bill_payment,
            color: DefaultColors.blue9D,
          onTap: () {
            showModalBottomSheet(
              context: context,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              builder: (BuildContext context) {
                return IBANCertificateBottomSheet();
              },
            );
            // Handle action for Request Cheque Book
          },),
        UISvgIcon(
            assetPath: AssetPath.icon.exchange,
            color: DefaultColors.blue9D,
          onTap: () {
            print("Request Cheque Book tapped");
            // Handle action for Request Cheque Book
          },),
        UISvgIcon(
            assetPath: AssetPath.icon.benificiary, color: DefaultColors.blue9D,
          onTap: () {
            print("Request Cheque Book tapped");
            // Handle action for Request Cheque Book
          },)
      ],
    );
  }
}
