// import 'package:db_uicomponents/db_uicomponents.dart';
// import 'package:db_uicomponents/src/components/ui_account_card_list.dart';
// import 'package:db_uicomponents/src/components/ui_cards_card_list.dart';
// import 'package:dkb_retail/core/constants/asset_path/asset_path.dart';
// import 'package:flutter/material.dart';
//
// import '../../../accounts/presentation/widget/account_card.dart';
//
// class TotalAvailBalCard extends StatefulWidget {
//   final String title;
//   final String currency;
//   final String? balance;
//   final String? outstandingBalance;
//   final bool isBalanceVisible;
//   final ValueChanged<bool> onToggleVisibility;
//   final List<AccountCard>? accountData;
//   final List<CreditCardUI>? cardData;
//
//   const TotalAvailBalCard({
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
//   _TotalAvailBalCardState createState() => _TotalAvailBalCardState();
// }
//
// class _TotalAvailBalCardState extends State<TotalAvailBalCard> {
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
//     return Column(
//         children:[ Container(
//           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//           decoration: BoxDecoration(
//             color: DefaultColors.white_0,
//             borderRadius: BorderRadius.circular(12),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.grey.withOpacity(0.6),
//                 blurRadius: 6,
//                 offset: Offset(0, 4),
//               ),
//             ],
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   UiTextNew.h5Regular(
//                     widget.title,
//                     color: DefaultColors.white_800,
//                   ),
//                   // SizedBox(height: 8),
//                   Row(
//                     children: [
//                       UiTextNew.h5Regular(
//                         '${widget.currency} ',
//                         color: DefaultColors.gray8A,
//                       ),
//                       if(widget.balance != null)
//                         UiTextNew.customRubik(
//                           _isBalanceVisible ? '${widget.balance}' : '********',
//                           color: DefaultColors.blue9D,
//                           fontSize: 18,
//                         ),
//                       if(widget.outstandingBalance != null)
//                         UiTextNew.customRubik(
//                           '${widget.outstandingBalance}',
//                           color: DefaultColors.blue9D,
//                           fontSize: 18,
//                         ),
//
//                     ],
//                   ),
//                 ],
//               ),
//               if(widget.outstandingBalance == null)
//                 GestureDetector(
//                   onTap: _toggleVisibility,
//                   child: UISvgIcon(
//                     assetPath: _isBalanceVisible ? AssetPath.icon.retailVisibilityIcon : AssetPath.icon.retailVisibilityOffIcon,
//                     color: DefaultColors.blue9D,
//                     // color: _isBalanceVisible ? DefaultColors.white_800 : DefaultColors.blue88,
//                     height: 24,
//                     width: 24,
//                   ),
//                 ),
//             ],
//           ),
//         ),
//           SizedBox(height: 20,),
//
//           if(widget.accountData != null)
//             AccountPageView(accounts: widget.accountData ?? []),
//           if(widget.cardData != null)
//             UiCardsCardList(cards: widget.cardData ?? []),
//
//         ]
//     );
//   }
// }
