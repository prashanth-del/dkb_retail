import 'package:dkb_retail/core/theme/tokens/theme_extension.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_strings/default_string.dart';
import '../../../../core/constants/colors.dart';

Widget rateTile(
    BuildContext context,
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
        leading: Image.asset(
          'assets/images/flags/$flag',
          width: w * 0.1,
          height: w * 0.1,
          fit: BoxFit.contain,
        ),
        title: Text(
          code,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: w * 0.04,
            color: DefaultColors.black,
          ),
        ),
        subtitle: Text(
          name,
          style: TextStyle(
            fontSize: w * 0.025,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 🔹 Buy Column
            ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: w * 0.18, // minimum width
                maxWidth: w * 0.18, // maximum width to prevent overflow
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    DefaultString.instance.buy,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: w * 0.03,
                    ),
                  ),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerRight,
                    child: Text(
                      buy,
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        color: DefaultColors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(width: w * 0.05),

            // 🔹 Sell Column
            ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: w * 0.18,
                maxWidth: w * 0.18,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    DefaultString.instance.sell,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: w * 0.03,
                    ),
                  ),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerRight,
                    child: Text(
                      sell,
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        color: DefaultColors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
