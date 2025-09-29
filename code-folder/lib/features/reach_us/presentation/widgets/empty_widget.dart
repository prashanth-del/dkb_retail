import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:flutter/material.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: UiTextNew.customRubik(
        "No results found",
        fontSize: 14,
        textAlign: TextAlign.center,
        color: DefaultColors.black,
      ),
    );
  }
}
