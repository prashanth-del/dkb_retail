import 'package:db_uicomponents/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pinput/pinput.dart';

class UIOtpField extends StatelessWidget {
  final TextEditingController? pinPutController;
  final FocusNode? pinPutFocusNode;
  final TextInputType keyboardType;
  final Function(String)? onChanged;
  final int length;

  const UIOtpField({
    this.pinPutController,
    this.pinPutFocusNode,
    this.length = 6,
    this.onChanged,
    this.keyboardType = TextInputType.number,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Pinput(
        controller: pinPutController,
        autofocus: false,
        focusNode: pinPutFocusNode,
        keyboardType: keyboardType,
        onChanged: onChanged,
        enableSuggestions: false,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')), // Allow only digits
        ],
        contextMenuBuilder: (context, editableTextState) {
          final List<Widget> buttonItems = [];
          final anchors = editableTextState.contextMenuAnchors;
          return AdaptiveTextSelectionToolbar(
            anchors: anchors,
            children: buttonItems,
          );
        },
        length: length,
        textInputAction: TextInputAction.done,
        defaultPinTheme: const PinTheme(
          width: 30,
          textStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: DefaultColors.blueB9C,
          ),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: DefaultColors.grayB0,
                width: 1.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
