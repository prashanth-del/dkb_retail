import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:dkb_retail/features/dashboard/presentation/controllers/dashboard_controllers.dart';
import 'package:flutter/material.dart';
import 'package:db_uicomponents/src/components/retail_expanded_dropdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/constants/asset_path/asset_path.dart';

class InstaTransfersCard extends ConsumerWidget {
  const InstaTransfersCard({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: DefaultColors.gray101,
          borderRadius: BorderRadius.circular(12),
          // gradient: LinearGradient(
          //   colors: [Color(0xFFC8D1ED),Color(0xFF90A1D5)],
          //   begin: Alignment.topCenter,
          //   end: Alignment.bottomCenter,
          // ),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Account Information
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                Row(
                  children: [
                    UISvgIcon(assetPath: AssetPath.icon.TransSplashIcon),
                    const SizedBox(width: 5),
                    const UiTextNew.h6Semibold(
                      'Quick \n Transfers',
                      color: DefaultColors.white_800,
                    ),
                  ],
                ),
                const Spacer(),
                const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        UiTextNew.customRubik(
                          '12312345671230',
                          fontSize: 12,
                          color: DefaultColors.white_800,
                        ),
                        UiTextNew.h5Regular(
                          '95,128.67 QAR',
                          color: DefaultColors.gray54,
                        ),
                      ],
                    ),
                    UIIconButton(
                      icon: Icons.keyboard_arrow_down,
                      // iconSize: 22,
                      iconColor: DefaultColors.blue9D,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Tabs
            TransactionTabs(
              onDomesticTap: () {
                ref.read(selectedTransferType.notifier).state = "domestic";
                // Handle Domestic Tab Tap
              },
              onInternationalTap: () {
                ref.read(selectedTransferType.notifier).state = "international";
                // Handle International Tab Tap
              },
            ),
            const SizedBox(height: 16),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UiTextNew.customRubik(
                  'Transaction Type',
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: DefaultColors.white_800,
                ),
                SizedBox(height: 8),
                DropdownExample(),
              ],
            ),

            const SizedBox(height: 16),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UiTextNew.customRubik(
                  'Send To',
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: DefaultColors.white_800,
                ),
                SizedBox(height: 8),
                DropdownExample(),
              ],
            ),

            const SizedBox(height: 16),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UiTextNew.h4Regular("Amount", color: DefaultColors.white_800),
                SizedBox(height: 8),

                UIInputField.outlined(
                  hintText: "QAR 0.00",
                  height: 52,

                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 5,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: context.screenWidth - 14,
              child: ElevatedButton(
                onPressed: () {
                  // Your button action
                  print('Button Pressed!');
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.0), // Rounded corners
                  ),
                  // padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12), // Button size
                  backgroundColor: DefaultColors.blue_300, // Button color
                  foregroundColor: Colors.white, // Text color
                ),
                child: const UiTextNew.customRubik(
                  'SEND',
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
            ),

            // Send Button
          ],
        ),
      ),
    );
  }
}

// Custom App Bar
// class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
//   final String title;
//
//   CustomAppBar({required this.title});
//
//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       backgroundColor: Colors.white,
//       elevation: 0,
//       title: Row(
//         children: [
//           Icon(Icons.flash_on, color: Colors.orange), // Example Icon
//           SizedBox(width: 8),
//           Text(title, style: TextStyle(color: Colors.black)),
//         ],
//       ),
//       actions: [
//         IconButton(
//           icon: Icon(Icons.chat, color: Colors.blue),
//           onPressed: () {
//             print('Chat Icon Pressed');
//           },
//         ),
//       ],
//     );
//   }
//
//   @override
//   Size get preferredSize => Size.fromHeight(kToolbarHeight);
// }

// Account Details Widget
class AccountDetails extends StatelessWidget {
  final String accountNumber;
  final String balance;

  const AccountDetails({
    super.key,
    required this.accountNumber,
    required this.balance,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          accountNumber,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        Text(
          balance,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ],
    );
  }
}

// Transaction Tabs Widget
class TransactionTabs extends ConsumerWidget {
  final VoidCallback onDomesticTap;
  final VoidCallback onInternationalTap;

  const TransactionTabs({
    super.key,
    required this.onDomesticTap,
    required this.onInternationalTap,
  });

  @override
  Widget build(BuildContext context, ref) {
    String selectedType = ref.watch(selectedTransferType);

    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: onDomesticTap,
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                color: selectedType == "domestic"
                    ? DefaultColors.blue_300
                    : DefaultColors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: UiTextNew.h5Regular(
                  'Domestic',
                  color: selectedType == "domestic"
                      ? DefaultColors.white_0
                      : DefaultColors.white_800,
                  // textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: GestureDetector(
            onTap: onInternationalTap,
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                color: selectedType == "domestic"
                    ? Colors.white
                    : DefaultColors.blue_300,
                // border: Border.all(color: Colors.blue),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: UiTextNew.h5Regular(
                  'International',
                  color: selectedType == "domestic"
                      ? DefaultColors.white_800
                      : DefaultColors.white_0,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// Reusable Dropdown Widget
class ReusableDropdown extends StatelessWidget {
  final String label;
  final String hint;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  const ReusableDropdown({
    super.key,
    required this.label,
    required this.hint,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(height: 8),
        Container(
          color: Colors.white,
          child: DropdownButtonFormField<String>(
            decoration: const InputDecoration(
              // contentPadding: EdgeInsets.symmetric(horizontal: 16),
              // border: OutlineInputBorder(
              //   borderRadius: BorderRadius.circular(8),
              //
              // ),
            ),
            hint: Text(hint),

            items: items
                .map((item) => DropdownMenuItem(value: item, child: Text(item)))
                .toList(),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}

// Reusable TextField Widget
class ReusableTextField extends StatelessWidget {
  final String label;
  final String prefix;
  final String hint;
  final ValueChanged<String> onChanged;

  const ReusableTextField({
    super.key,
    required this.label,
    required this.prefix,
    required this.hint,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(height: 8),
        Container(
          color: Colors.white,
          child: TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              prefixText: '$prefix ',
              hintText: hint,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}

// Reusable Button Widget
class ReusableButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const ReusableButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        backgroundColor: Colors.blue,
      ),
      child: Text(text, style: const TextStyle(fontSize: 16)),
    );
  }
}

// Padding(
//   padding: const EdgeInsets.all(16.0),
//   child: Card(
//     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.circular(12),
//     ),
//     color: Colors.blue[50],
//     child: Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Header
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Row(
//                 children: [
//                   Icon(Icons.flash_on, color: Colors.orange),
//                   SizedBox(width: 8),
//                   Text(
//                     'Insta Transfers',
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ],
//               ),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: [
//                   Text(
//                     '12312345671230',
//                     style: TextStyle(
//                       fontSize: 14,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   Text(
//                     '95,128.67 QAR',
//                     style: TextStyle(
//                       fontSize: 14,
//                       color: Colors.black54,
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//           SizedBox(height: 16),
//
//           // Domestic and International Buttons
//           Row(
//             children: [
//               Expanded(
//                 child: ElevatedButton(
//                   onPressed: () {},
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.blue,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                   ),
//                   child: Text('Domestic'),
//                 ),
//               ),
//               SizedBox(width: 8),
//               Expanded(
//                 child: ElevatedButton(
//                   onPressed: () {},
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.white,
//                     foregroundColor: Colors.blue,
//                     side: BorderSide(color: Colors.blue),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                   ),
//                   child: Text('International'),
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 16),
//
//           // Form Fields
//           DropdownField(hintText: 'Transaction Type'),
//           SizedBox(height: 16),
//           DropdownField(hintText: 'Send To'),
//           SizedBox(height: 16),
//           TextField(
//             decoration: InputDecoration(
//               labelText: 'Amount',
//               prefixText: 'QAR ',
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(8),
//               ),
//             ),
//             keyboardType: TextInputType.number,
//           ),
//           SizedBox(height: 16),
//
//           // Send Button
//           SizedBox(
//             width: double.infinity,
//             child: ElevatedButton(
//               onPressed: () {},
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.blue,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//               ),
//               child: Text('SEND'),
//             ),
//           ),
//         ],
//       ),
//     ),
//   ),
// ),
