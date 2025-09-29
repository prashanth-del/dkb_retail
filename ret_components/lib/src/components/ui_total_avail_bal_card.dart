// import 'package:db_uicomponents/components.dart';
// import 'package:db_uicomponents/db_uicomponents.dart';
// import 'package:db_uicomponents/src/components/ui_account_card_list.dart';
// import 'package:db_uicomponents/src/components/ui_cards_card_list.dart';
// import 'package:flutter/material.dart';
//
// class UiTotalAvailBalCard extends StatefulWidget {
//   final String title;
//   final String currency;
//   final String? balance;
//   final String? outstandingBalance;
//   final bool isBalanceVisible;
//   final ValueChanged<bool> onToggleVisibility;
//   final List<AccountCard>? accountData;
//   final List<CreditCardUI>? cardData;
//
//   const UiTotalAvailBalCard({
//     super.key,
//     required this.title,
//     required this.currency,
//     this.balance,
//     this.isBalanceVisible = false,
//     this.outstandingBalance,
//     required this.onToggleVisibility,
//     this.accountData,
//     this.cardData,
//   });
//
//   @override
//   _UiTotalAvailBalCardState createState() => _UiTotalAvailBalCardState();
// }
//
// class _UiTotalAvailBalCardState extends State<UiTotalAvailBalCard> {
//   late bool _isBalanceVisible;
//
//   @override
//   void initState() {
//     super.initState();
//     _isBalanceVisible = widget.isBalanceVisible;
//   }
//
//   void _toggleVisibility() {
//     setState(() {
//       _isBalanceVisible = !_isBalanceVisible;
//     });
//     widget.onToggleVisibility(_isBalanceVisible);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(children: [
//       Container(
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//         decoration: BoxDecoration(
//           color: DefaultColors.white_0,
//           borderRadius: BorderRadius.circular(12),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(0.6),
//               blurRadius: 6,
//               offset: Offset(0, 4),
//             ),
//           ],
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 UiTextNew.h5Regular(
//                   widget.title,
//                   color: DefaultColors.white_800,
//                 ),
//                 SizedBox(height: 8),
//                 Row(
//                   children: [
//                     UiTextNew.h5Regular(
//                       '${widget.currency} ',
//                       color: DefaultColors.gray8A,
//                     ),
//                     if (widget.balance != null)
//                       UiTextNew.customRubik(
//                         _isBalanceVisible ? '${widget.balance}' : '********',
//                         color: DefaultColors.blue88,
//                         fontSize: 18,
//                       ),
//                     if (widget.outstandingBalance != null)
//                       UiTextNew.customRubik(
//                         '${widget.outstandingBalance}',
//                         color: DefaultColors.blue88,
//                         fontSize: 18,
//                       ),
//                   ],
//                 ),
//               ],
//             ),
//             if (widget.outstandingBalance == null)
//               GestureDetector(
//                 onTap: _toggleVisibility,
//                 child: Icon(
//                   _isBalanceVisible ? Icons.visibility : Icons.visibility_off,
//                   color: _isBalanceVisible
//                       ? DefaultColors.white_800
//                       : DefaultColors.blue88,
//                   size: 24,
//                 ),
//               ),
//           ],
//         ),
//       ),
//       SizedBox(
//         height: 25,
//       ),
//
//       if (widget.accountData != null)
//         UiSwiper<AccountCard>.swiper3(
//           elements: widget.accountData!,
//           itemBuilder: (context, index) {
//             return Column(children: [
//               Flexible(child: widget.accountData![index]),
//               const UiSpace.vertical(20)
//             ]);
//           },
//           height: context.screenHeight / 4.5,
//         ),
//       // AccountPageView(accounts: widget.accountData ?? []),
//       if (widget.cardData != null)
//         UiCardsCardList(cards: widget.cardData ?? []),
//     ]);
//   }
// }
