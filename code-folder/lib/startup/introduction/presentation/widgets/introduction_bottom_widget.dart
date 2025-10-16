import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_strings/default_string.dart';
import '../../../../core/router/app_router.dart';
import 'db_button.dart';

Widget walletScreenBottom({required BuildContext context}) {
  final width = MediaQuery.of(context).size.width;

  final height = MediaQuery.of(context).size.height;
  return Column(
    children: [
      Divider(thickness: width * 0.003),
      SizedBox(height: height * 0.03),
      Row(
        children: [
          Expanded(
            child: DbButton(
              title: DefaultString.instance.registerNow,
              onTap: () {
                context.router.push(RegistrationStartRoute());
              },
              isOutlinedButton: true,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: DbButton(
              title: DefaultString.instance.walletLogin,
              onTap: () {
                context.router.replace(LoginRoute());
              },
            ),
          ),
        ],
      ),
      SizedBox(height: height * 0.075),
    ],
  );
}
