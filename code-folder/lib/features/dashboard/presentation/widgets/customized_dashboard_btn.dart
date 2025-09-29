import 'package:db_uicomponents/components.dart';
import 'package:dkb_retail/core/utils/extensions/locale_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/colors.dart';

Widget customizedDashboardBtn(BuildContext context, WidgetRef ref) {
  return Center(
    child: UIButton.rounded(
      onPressed: () {},
      btnCurve: MediaQuery.of(context).size.width * 0.3,
      label: ref.getLocaleString(
        "Customized dashboard",
        defaultValue: "Customized dashboard",
      ),
      width: MediaQuery.of(context).size.width * 0.7,

      txtColor: DefaultColors.black,
      backgroundColor: DefaultColors.grey.withAlpha(100),
      maxWidth: MediaQuery.of(context).size.width * 0.7,
    ),
  );
}
