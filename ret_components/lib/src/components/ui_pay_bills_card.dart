import 'package:db_uicomponents/components.dart';
import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:flutter/material.dart';

class PayBillsWidget extends StatelessWidget {
  final String title;
  final List<BillItem> items;
  final VoidCallback? onViewAll;

  const PayBillsWidget({
    Key? key,
    required this.title,
    required this.items,
    this.onViewAll,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 161,
      child: Card(
        // margin: const EdgeInsets.all(16),
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  UiTextNew.customRubik(
                    title,
                    fontSize: 16,
                    color: DefaultColors.white_800,
                  ),

                  GestureDetector(
                    onTap: onViewAll,
                    child: const UiTextNew.customRubik(
                      'View All',
                      fontSize: 12,
                      color:DefaultColors.blue9D,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Bill Items List
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: items.map((item) => BillItemExactUI(item: item)).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BillItem {
  final Image imageUrl;
  final String name;
  final String detail;
  final String amount;
  final Color backgroundColor;

  BillItem({
    required this.imageUrl,
    required this.name,
    required this.detail,
    required this.amount,
    this.backgroundColor = Colors.white,
  });
}

class BillItemExactUI extends StatelessWidget {
  final BillItem item;

  const BillItemExactUI({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 72,
      height: 82,
      // color: Colors.white,
      // margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          // Image/Icon
          Container(
            height: 50,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Container(
                  height: 41,
                  width: 41,
                  // padding: const EdgeInsets.all(0.0),
                  child: item.imageUrl,
                  // child: Image.asset(
                  //   item.imageUrl,
                  //   fit: BoxFit.contain,
                  // ),
                ),
                // Amount Tag
                Container(
                  height: 13,
                  decoration: BoxDecoration(
                    color: Colors.red.shade50,
                    border: Border.all(color: Colors.red, width: 1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 0),
                  child: UiTextNew.customRubik(
                    item.amount,
                    fontSize: 8,
                    fontWeight: FontWeight.w400,
                    color:DefaultColors.redDB,
                  ),
                ),
              ],
            ),
          ),
          // const SizedBox(height: 8),
          // Name
          UiTextNew.customRubik(
            item.name,
            fontSize: 11,
            color:DefaultColors.white_800,
          ),
          // const SizedBox(height: 4),
          // Detail
          UiTextNew.customRubik(
            item.detail,
            fontSize: 11,
            fontWeight: FontWeight.w400,
            color:DefaultColors.gray8A,
          ),

        ],
      ),
    );
  }
}
