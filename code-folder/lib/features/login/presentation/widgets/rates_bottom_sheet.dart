import 'package:auto_route/auto_route.dart';
import 'package:db_uicomponents/components.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_strings/default_string.dart';
import '../../../../core/constants/asset_path/asset_path.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/router/app_router.dart';
import '../../../common/presentation/components/ui_image_tile.dart';

Widget ratesBottomSheet(BuildContext context) {
  final size = MediaQuery.of(context).size;
  final width = size.width;
  final height = size.height;
  return Column(
    children: [
      // Align(
      //   alignment: AlignmentGeometry.centerRight,
      //   child: IconButton(
      //     onPressed: () {
      //       context.router.pop();
      //     },
      //     icon: Icon(
      //       Icons.close,
      //       color: DefaultColors.white,
      //       size: MediaQuery.of(context).size.width * 0.075,
      //     ),
      //   ),
      // ),
      Container(
        decoration: BoxDecoration(
          color: DefaultColors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(MediaQuery.of(context).size.width * 0.05),
            topRight: Radius.circular(MediaQuery.of(context).size.width * 0.05),
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Center(
              child:
              Container(
                margin: EdgeInsets.only(bottom: height * 0.01),
                width: width * 0.12,
                height: height * 0.005,
                decoration: BoxDecoration(
                  color: DefaultColors.grayLightBase,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                UiTextNew.custom(
                  DefaultString.instance.chooseRateType,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: DefaultColors.blue88,
                ),
                // GestureDetector(
                //   onTap: () {
                //     Navigator.pop(context);
                //   },
                //   child: Container(
                //     height: 30,
                //     width: 30,
                //     alignment: Alignment.center,
                //     decoration: BoxDecoration(
                //       shape: BoxShape.circle,
                //       color: Colors.white,
                //     ),
                //     child: Icon(
                //       Icons.close,
                //       color: DefaultColors.black,
                //
                //       size: 22,
                //     ),
                //   ),
                // ),
              ],
            ),
            UiSpace.vertical(30),
            UiImageTile(
              title: DefaultString.instance.fxRatesTitle,
              imageName: AssetPath.image.fxRatesImage,
              ontap: () {
                context.router.push(FxRatesRoute());
              },
            ),
            UiSpace.vertical(20),
            UiImageTile(
              title: DefaultString.instance.profitRatesTitle,
              imageName: AssetPath.image.profitRatesImage,
              ontap: () {
                // context.router.push(ProfitRatesPageRoute());
                context.router.push(ProfitRatesRoute());
              },
            ),
          ],
        ),
      ),
    ],
  );
}

// Future ratesBottomSheet(BuildContext context) {
//   return showModalBottomSheet(
//     backgroundColor: Colors.transparent,
//     context: context,
//     isScrollControlled: true,
//     constraints: BoxConstraints(
//       minHeight: MediaQuery.of(context).size.height * 0.28,
//     ),
//     builder: (context) {
//       return Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Align(
//             alignment: AlignmentGeometry.centerRight,
//             child: IconButton(
//               onPressed: () {
//                 context.router.pop();
//               },
//               icon: Icon(Icons.close, color: DefaultColors.white),
//             ),
//           ),
//           Container(
//             decoration: BoxDecoration(
//               color: DefaultColors.white,
//               borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(
//                   MediaQuery.of(context).size.width * 0.05,
//                 ),
//                 topRight: Radius.circular(
//                   MediaQuery.of(context).size.width * 0.05,
//                 ),
//               ),
//             ),
//             padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 UiTextNew.custom(
//                   "Choose the rates type",
//                   fontWeight: FontWeight.bold,
//                   fontSize: 20,
//                   color: DefaultColors.blue88,
//                 ),
//                 UiSpace.vertical(30),
//                 UiImageTile(
//                   title: "FX Rates",
//                   imageName: AssetPath.image.fxRatesImage,
//                   ontap: () {
//                     context.router.push(FxRatesRoute());
//                   },
//                 ),
//                 UiSpace.vertical(20),
//                 UiImageTile(
//                   title: "Profit Rates",
//                   imageName: AssetPath.image.profitRatesImage,
//                   ontap: () {
//                     context.router.push(ProfitRatesRoute());
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ],
//       );
//     },
//   );
// }
