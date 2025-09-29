import 'package:flutter/material.dart';

Widget rateTile(
  String flag,
  String code,
  String name,
  String buy,
  String sell,
  double w,
  double h,
) {
  return Column(
    children: [
      ListTile(
        leading: Text(flag, style: TextStyle(fontSize: w * 0.08)),
        title: Text(
          code,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: w * 0.04),
        ),
        subtitle: Text(name, style: TextStyle(fontSize: w * 0.03)),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Buy",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: w * 0.03,
                  ),
                ),
                Text(
                  buy,
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: w * 0.03,
                  ),
                ),
              ],
            ),
            SizedBox(width: w * 0.05),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Sell",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: w * 0.03,
                  ),
                ),
                Text(
                  sell,
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: w * 0.03,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ],
  );
}
