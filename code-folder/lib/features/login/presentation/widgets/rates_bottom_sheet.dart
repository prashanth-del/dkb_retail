import 'package:auto_route/auto_route.dart';
import 'package:db_uicomponents/components.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/asset_path/asset_path.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/router/app_router.dart';
import '../../../common/components/ui_image_tile.dart';

Widget ratesBottomSheet(BuildContext context) {
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
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                UiTextNew.custom(
                  "Choose the rates type",
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: DefaultColors.blue88,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 30,
                    width: 30,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: Icon(
                      Icons.close,
                      color: DefaultColors.black,

                      size: 22,
                    ),
                  ),
                ),
              ],
            ),
            UiSpace.vertical(30),
            UiImageTile(
              title: "FX Rates",
              imageName: AssetPath.image.fxRatesImage,
              ontap: () {
                context.router.push(FxRatesRoute());
              },
            ),
            UiSpace.vertical(20),
            UiImageTile(
              title: "Profit Rates",
              imageName: AssetPath.image.profitRatesImage,
              ontap: () {
                context.router.push(ProfitRatesPageRoute());
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
