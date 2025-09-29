import 'package:flutter/material.dart';

import '../../../../common/colors.dart';
import '../../../../common/constant.dart';

 class QuickLinks extends StatefulWidget {
  const QuickLinks({super.key});

  @override
  State<QuickLinks> createState() => _QuickLinksState();
}

class _QuickLinksState extends State<QuickLinks> {
   @override
   Widget build(BuildContext context) {
     return SingleChildScrollView(
       child: Padding(
         padding: const EdgeInsets.all(8.0),
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             Card(
               elevation:0,
               color: cardBackGroundColor,// Adds shadow for a modern look
               shape: RoundedRectangleBorder(
                 borderRadius: BorderRadius.circular(12),
               ),
               child: Center(
                 child: _gridSection([
                   GridItem(Constants.activateCards,'assets/icons/ic_activate_cards.png',),
                   GridItem(Constants.blockCards, 'assets/icons/ic_block_cards.png'),
                   GridItem(Constants.internationalActivation,'assets/icons/ic_International_usage.png'),
                   GridItem(Constants.chequeBookRequest,'assets/icons/ic_cheque_book_request.png'),
                   GridItem(Constants.activeCvv, 'assets/icons/ic_cvv.png'),
                 ]),
               ),
             ),
             const SizedBox(height: 20),
             Card(
               elevation:0,
               color: cardBackGroundColor,// Adds shadow for a modern look
               shape: RoundedRectangleBorder(
                 borderRadius: BorderRadius.circular(12),
               ),
               child: Center(
                 child: Column(
                   children: [
                     _sectionTitle("Apply Now"),
                     _gridSection([
                       GridItem(Constants.cards, 'assets/icons/ic_cards.png'),
                       GridItem(Constants.loans, 'assets/icons/ic_loans.png'),
                       GridItem(Constants.insurance, 'assets/icons/ic_Insurance.png'),
                       GridItem(Constants.deposits, 'assets/icons/ic_deposits.png'),
                     ]),
                   ],
                 ),
               ),
             ),
           ],
         ),
       ),
     );
   }

   // Section Title Widget
   Widget _sectionTitle(String title) {
     return Padding(
       padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
       child: Center(
         child: Text(
           title,
           style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
         ),
       ),
     );
   }

   // Grid Section
   Widget _gridSection(List<GridItem> items) {
     return Padding (
       padding: const EdgeInsets.all(8.0),
       child: GridView.builder(
         shrinkWrap: true,
         physics: const NeverScrollableScrollPhysics(),
         itemCount: items.length,
         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
           crossAxisCount: 4,
           crossAxisSpacing: 8.0,
           mainAxisSpacing: 8.0,
         ),
         itemBuilder: (context, index) {
           final item = items[index];
           return InkWell(
             onTap: (){

             },
             child: Column(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 Image.asset(
                   item.icon,
                   height: 35,
                   width: 35,
                 ),
                 const SizedBox(height: 4),
                   Text(
                     item.title,
                     style: const TextStyle(fontSize: 12),
                     textAlign: TextAlign.center,
                   ),
               ],
             ),
           );
         },
       ),
     );
   }
}

 class GridItem {
   final String title;
   final String icon;

   GridItem(this.title, this.icon);
 }
