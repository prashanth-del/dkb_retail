import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:flutter/material.dart';

class InstaTransfersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(0.0),
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              colors: [Color(0xFFC8D1ED),Color(0xFF90A1D5)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            boxShadow: [
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
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.flash_on, color: Colors.orange),
                      SizedBox(width: 8),
                      UiTextNew.h6Semibold(
                        'Insta \n Transfers',
                        color: DefaultColors.white_800,
                      )

                    ],
                  ),
                  Spacer(),
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
                      )
                    ],
                  ),
                  UIIconButton(
                    icon: Icons.keyboard_arrow_down,
                    iconSize: 22,
                    iconColor: DefaultColors.blue9D,
                  ),
                ],
              ),
              SizedBox(height: 16),
              // Tabs
              TransactionTabs(
                onDomesticTap: () {
                  // Handle Domestic Tab Tap
                },
                onInternationalTap: () {
                  // Handle International Tab Tap
                },
              ),
              SizedBox(height: 16),
              // UiDropdown(
              //   items: [
              //     UiDropdownValue(value: 'Type 1', labelText: 'Type 1'),
              //     UiDropdownValue(value: "value", labelText: "Type 2")
              //   ],
              //   hintText: 'Please Select',
              //   labelText: 'Transaction Type',
              //   labelTextStyle: UiTextNew.h4Regular(
              //     'Transaction Type',
              //     color: DefaultColors.white_800,
              //   ),
              // ),
              // Dropdown and Input Fields
              ReusableDropdown(
                label: 'Transaction Type',
                hint: 'Please Select',
                items: ['Type 1', 'Type 2', 'Type 3'],
                onChanged: (value) {
                  print('Transaction Type: $value');
                },
              ),
              SizedBox(height: 16),
              ReusableDropdown(
                label: 'Send To',
                hint: 'Please Select',
                items: ['Recipient 1', 'Recipient 2', 'Recipient 3'],
                onChanged: (value) {
                  print('Send To: $value');
                },
              ),
              SizedBox(height: 16),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Amount"),
                  UIInputField.outlined(
                    hintText: "ff",
                    contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  ),

                ],
              ),
              SizedBox(height: 24),
              SizedBox(
                width: context.screenWidth - 14,
                child: UIButton.rounded(
                  onPressed: () {},
                  // style: ElevatedButton.styleFrom(
                  //   padding: EdgeInsets.symmetric(horizontal: 16),
                  //   backgroundColor: Colors.blue,
                  // ),
                  label: '',
                  child: Text(
                    "SEND",
                    style: TextStyle(fontSize: 16),
                  ),),
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

  AccountDetails({required this.accountNumber, required this.balance});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          accountNumber,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        Text(
          balance,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ],
    );
  }
}

// Transaction Tabs Widget
class TransactionTabs extends StatelessWidget {
  final VoidCallback onDomesticTap;
  final VoidCallback onInternationalTap;

  TransactionTabs({required this.onDomesticTap, required this.onInternationalTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: onDomesticTap,
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                color: DefaultColors.blue88,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: UiTextNew.h5Regular(
                  'Domestic',
                  color: DefaultColors.white_0,
                  // textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          child: GestureDetector(
            onTap: onInternationalTap,
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                // border: Border.all(color: Colors.blue),
                borderRadius: BorderRadius.circular(8),
              ),
              child:const Center(
                child: UiTextNew.h5Regular(
                  'International',
                  color: DefaultColors.white_800,
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

  ReusableDropdown({
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
        SizedBox(height: 8),
        Container(
          color: Colors.white,
          child: DropdownButtonFormField<String>(
            decoration: InputDecoration(
              // contentPadding: EdgeInsets.symmetric(horizontal: 16),
              // border: OutlineInputBorder(
              //   borderRadius: BorderRadius.circular(8),
              //
              // ),
            ),
            hint: Text(hint),

            items: items
                .map((item) => DropdownMenuItem(
              value: item,
              child: Text(item),
            ))
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

  ReusableTextField({
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
        SizedBox(height: 8),
        Container(
          color: Colors.white,
          child: TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              prefixText: '$prefix ',
              hintText: hint,
              contentPadding: EdgeInsets.symmetric(horizontal: 16),
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

  ReusableButton({required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 16),
        backgroundColor: Colors.blue,
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 16),
      ),
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
