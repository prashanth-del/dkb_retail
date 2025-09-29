import 'package:db_uicomponents/src/components/ui_pay_bills_card.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/asset_path/asset_path.dart';

class PayBill extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PayBillsWidget(
      title: 'Pay Bills',
      onViewAll: () {
        // Handle View All Tap
        print('View All Tapped');
      },
      items: [
        BillItem(
          imageUrl: Image.asset(
            AssetPath.image.vodafoneImg,
            fit: BoxFit.cover,
          ),
          name: 'Vodafone',
          detail: '77658907',
          amount: '600 QAR',
          backgroundColor: Colors.white,
        ),
        BillItem(
          imageUrl: Image.asset(
            AssetPath.image.kharamaaImg,
            fit: BoxFit.cover,
          ),
          name: 'Kahraamaa',
          detail: '768904',
          amount: '600.78 QAR',
          backgroundColor: Colors.white,
        ),
        BillItem(
          imageUrl: Image.asset(
            AssetPath.image.vodafoneImg,
            fit: BoxFit.contain,
          ),
          name: 'Credit Card',
          detail: 'XXXX-9085',
          amount: '8094 QAR',
          backgroundColor: Colors.white,
        ),
        BillItem(
          imageUrl: Image.asset(
            AssetPath.image.vodafoneImg,
            fit: BoxFit.contain,
          ),
          name: 'Vodafone',
          detail: '77658907',
          amount: '600 QAR',
          backgroundColor: Colors.white,
        ),
      ],
    );
  }
}
