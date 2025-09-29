import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:flutter/material.dart';

class UiLoader extends StatelessWidget {
  final String loadingText;
  const UiLoader({super.key, this.loadingText = 'Loading...'});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: 120,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: DefaultColors.white),
      child:  Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
              child: CircularProgressIndicator.adaptive(
                valueColor: AlwaysStoppedAnimation<Color>(DefaultColors.blue9D),
                strokeWidth: 2,
              )),
          UiSpace.vertical(20),
          UiTextNew.b2Regular(loadingText, color: DefaultColors.blue9B,)
        ],
      ),
    );
  }
}
