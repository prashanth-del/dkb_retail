import 'package:auto_route/auto_route.dart';
import 'package:db_uicomponents/db_uicomponents.dart' hide DefaultColors;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/constants/colors.dart';

Widget enterMpinWidget(BuildContext context) {
  final pinNode = FocusNode();
  pinNode.requestFocus();
  return Column(
    mainAxisAlignment: MainAxisAlignment.end,
    mainAxisSize: MainAxisSize.min,
    children: [
      Align(
        alignment: AlignmentGeometry.centerRight,
        child: IconButton(
          onPressed: () {
            context.router.pop();
          },
          icon: Icon(
            Icons.close,
            color: DefaultColors.white,
            size: MediaQuery.of(context).size.width * 0.075,
          ),
        ),
      ),
      Container(
        decoration: BoxDecoration(
          color: DefaultColors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(MediaQuery.of(context).size.width * 0.05),
            topRight: Radius.circular(MediaQuery.of(context).size.width * 0.05),
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            UiTextNew.custom(
              "Enter M-Pin",
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: DefaultColors.blue88,
            ),
            UiSpace.vertical(30),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: pinNode.hasFocus
                      ? DefaultColors.blue98
                      : DefaultColors.black,
                ),
              ),
              child: TextFormField(
                maxLength: 4,
                obscureText: true,

                focusNode: pinNode,
                keyboardType: const TextInputType.numberWithOptions(),
                style: const TextStyle(fontWeight: FontWeight.w600),
                onFieldSubmitted: (_) => pinNode.unfocus(),
                onChanged: (value) {
                  // ref.read(pinNumberProvider.notifier).state = value;
                },
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                ],
                decoration: const InputDecoration(
                  counterText: '',
                  hintText: "----",
                  label: Text('Enter PIN'),
                  labelStyle: TextStyle(
                    fontSize: 14,
                    color: DefaultColors.black,
                    fontWeight: FontWeight.w500,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
            UiSpace.vertical(30),
            Center(
              child: RichText(
                text: TextSpan(
                  style: TextStyle(color: DefaultColors.black, fontSize: 12),
                  children: [
                    TextSpan(text: "Forgot M-Pin?"),
                    TextSpan(
                      text: " Login using Password?",
                      style: TextStyle(
                        color: DefaultColors.blue9B,
                        fontWeight: FontWeight.w700,
                        decoration: TextDecoration.underline,
                        decorationColor: DefaultColors.blue9B,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            UiSpace.vertical(5),
            UIButton.rounded(
              onPressed: () {},
              isRoundedButton: true,
              maxWidth: MediaQuery.of(context).size.width,
              height: 45,
              label: 'Submit',

              btnCurve: 20,
              backgroundColor: DefaultColors.blue98,
              txtColor: DefaultColors.white,
              margin: EdgeInsets.zero,
            ),
          ],
        ),
      ),
    ],
  );
}
