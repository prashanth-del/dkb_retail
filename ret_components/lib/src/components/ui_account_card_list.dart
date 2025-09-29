import 'package:db_uicomponents/components.dart';
import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:flutter/material.dart';

// class AccountCard extends StatelessWidget {
//   final String accountType;
//   final String accountNumber;
//   final String balance;
//   final String currency;
//   final DecorationImage imgBg1;
//   final VoidCallback? onTap; // Add the onTap callback for navigation
//
//   const AccountCard({
//     required this.accountType,
//     required this.accountNumber,
//     required this.balance,
//     required this.currency,
//     required this.imgBg1,
//     this.onTap, // Make onTap optional
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap, // Trigger navigation when tapped
//       child: Container(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(16),
//           image: imgBg1,
//           color: DefaultColors.primaryBlue,
//         ),
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               UiTextNew.h4Regular(
//                 accountType,
//                 color: DefaultColors.white,
//               ),
//               SizedBox(height: 8),
//               UiTextNew.customRubik(
//                 accountNumber,
//                 color: DefaultColors.white,
//                 fontSize: 14,
//                 fontWeight: FontWeight.w600,
//               ),
//               Spacer(),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   UiTextNew.h4Regular(
//                     'Current Balance',
//                     color: DefaultColors.white_f3,
//                   ),
//                   Row(
//                     children: [
//                       UiTextNew.h5Regular(
//                         currency,
//                         color: DefaultColors.white_0,
//                       ),
//                       SizedBox(width: 4),
//                       UiTextNew.customRubik(
//                         '********',
//                         color: DefaultColors.white,
//                         fontSize: 16,
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

class DotIndicator extends StatelessWidget {
  final bool isActive;

  const DotIndicator({required this.isActive, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.0),
      height: 6.0,
      width: 6.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive ? DefaultColors.blue9D : DefaultColors.grayB3,
      ),
    );
  }
}
//
// class AccountPageView extends StatefulWidget {
//   final List<AccountCard> accounts;
//
//   const AccountPageView({
//     required this.accounts,
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   _AccountPageViewState createState() => _AccountPageViewState();
// }
//
// class _AccountPageViewState extends State<AccountPageView> {
//   int currentIndex = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Container(
//           height: 200,
//           color: Colors.transparent,
//           child: PageView.builder(
//             itemCount: widget.accounts.length,
//             onPageChanged: (index) {
//               setState(() {
//                 currentIndex = index;
//               });
//             },
//             itemBuilder: (context, index) {
//               final account = widget.accounts[index];
//               return Padding(padding: EdgeInsets.symmetric(horizontal: 5), child: AccountCard(
//                 accountType: account.accountType,
//                 accountNumber: account.accountNumber,
//                 balance: account.balance,
//                 currency: account.currency,
//                 imgBg1: account.imgBg1,
//                 onTap: account.onTap,
//                 // imgBg2: account.imgBg2,
//               ),);
//             },
//           ),
//         ),
//         // Dots Indicator
//         SingleChildScrollView(
//           scrollDirection: Axis.horizontal,
//           child: Padding(
//             padding: const EdgeInsets.symmetric(vertical: 8.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: List.generate(
//                 widget.accounts.length,
//                 (index) => DotIndicator(isActive: currentIndex == index),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
