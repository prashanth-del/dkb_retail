import 'package:db_uicomponents/styles.dart';
import 'package:flutter/material.dart';

enum _InputType {
  outlined,
  underlined,
}

class UIInputField extends StatefulWidget {
  final String hintText;
  final TextEditingController? controller;
  final String? initialValue;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool obscure;
  final FocusNode? focus;
  final String? helperText;
  final VoidCallback? onTap;
  final ValueChanged<String>? onChanged;
  final ValueSetter<String>? onFieldSubmitted;
  final Function()? onEditDone;
  final String? Function(String?)? validator;
  final bool readOnly;
  final TextInputAction? textInputAction;
  final TextInputType? textInputType;
  final bool autofocus;
  final double? height;
  final TextAlignVertical? textAlignVertical;
  final bool revealObscuredOnLongPress;
  final EdgeInsets contentPadding;
  final String? label;

  const UIInputField.outlined({
    required this.hintText,
    this.helperText,
    this.controller,
    this.initialValue,
    this.suffixIcon,
    this.prefixIcon,
    this.obscure = false,
    this.onTap,
    this.focus,
    this.validator,
    this.onChanged,
    this.onFieldSubmitted,
    this.onEditDone,
    this.readOnly = false,
    this.textInputAction,
    this.textInputType,
    this.autofocus = false,
    this.height = 44,
    this.textAlignVertical,
    this.revealObscuredOnLongPress = false,
    this.contentPadding =
        const EdgeInsets.symmetric(horizontal: 15, vertical: 15.5),
    this.label,
    super.key,
  }) : _inputType = _InputType.outlined;

  const UIInputField.underlined({
    required this.hintText,
    this.helperText,
    this.controller,
    this.initialValue,
    this.suffixIcon,
    this.prefixIcon,
    this.obscure = false,
    this.onTap,
    this.focus,
    this.validator,
    this.onChanged,
    this.onFieldSubmitted,
    this.onEditDone,
    this.readOnly = false,
    this.textInputAction,
    this.textInputType,
    this.autofocus = false,
    this.height = 35,
    this.textAlignVertical,
    this.revealObscuredOnLongPress = false,
    this.contentPadding = const EdgeInsets.symmetric(
      vertical: 10,
      horizontal: 0,
    ),
    this.label,
    super.key,
  }) : _inputType = _InputType.underlined;

  final _InputType _inputType;

  @override
  State<UIInputField> createState() => _UIInputFieldState();
}

class _UIInputFieldState extends State<UIInputField> {
  bool revealText = false;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focus ?? FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    final inputFieldStyles = _UIInputFieldStyles(context, widget._inputType);

    return Container(
      decoration: widget._inputType == _InputType.outlined
          ? BoxDecoration(
              color: Colors.white, // Background color of the text field
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: DefaultColors.blue_150),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26.withOpacity(0.1),
                  spreadRadius: 0.5,
                  blurRadius: 6,
                  offset: const Offset(0, 4), // Shadow direction
                ),
              ],
            )
          : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.label != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 3.0, left: 0),
              child: Text(
                widget.label!,
                style: inputFieldStyles.getLabelTextStyle,
              ),
            ),
          Container(
            // height: widget.height,
            margin: widget._inputType == _InputType.outlined
                ? const EdgeInsets.only(top: 4)
                : null,
            padding: EdgeInsets.symmetric(vertical: 8),
            child: TextFormField(
              focusNode: _focusNode,
              controller: widget.controller,
              enableInteractiveSelection: false,
              textAlignVertical: widget.textAlignVertical,
              autofocus: widget.autofocus,
              keyboardType: widget.textInputType,
              textInputAction: widget.textInputAction,
              readOnly: widget.readOnly,
              onChanged: widget.onChanged,
              onEditingComplete: widget.onEditDone ?? () {},
              onTap: () async {
                _focusNode.unfocus();
                _focusNode.requestFocus();
                widget.onTap?.call();
              },
              onFieldSubmitted: widget.onFieldSubmitted,
              validator: widget.validator,
              initialValue: widget.initialValue,
              style: inputFieldStyles.getTextStyle,
              cursorColor: widget._inputType == _InputType.outlined
                  ? const Color(0xFFC6E2FA)
                  : const Color(0xFF113E98),
              obscureText: widget.obscure && !revealText,
              obscuringCharacter: '*',
              decoration: InputDecoration(
                counterText: '',
                contentPadding: widget.contentPadding,
                filled: true,
                isDense: true,
                fillColor: inputFieldStyles.getFillColor,
                hintText: widget.hintText,
                hintStyle: inputFieldStyles.getHintStyle,
                border: inputFieldStyles.getBorder,
                enabledBorder: inputFieldStyles.getEnabledBorder,
                focusedBorder: inputFieldStyles.getFocusedBorder,
                prefixIcon: widget.prefixIcon,
                prefixIconConstraints: const BoxConstraints(maxWidth: 40),
                suffixIcon: widget.suffixIcon != null
                    ? GestureDetector(
                        onLongPress: () {
                          if (widget.revealObscuredOnLongPress) {
                            setState(() => revealText = true);
                          }
                        },
                        onLongPressEnd: (_) {
                          if (widget.revealObscuredOnLongPress) {
                            setState(() => revealText = false);
                          }
                        },
                        child: widget.suffixIcon,
                      )
                    : null,
              ),
            ),
          ),
          if (widget.helperText != null) ...[
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  widget.helperText!,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF113E98),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _UIInputFieldStyles {
  final BuildContext context;
  final _InputType type;

  _UIInputFieldStyles(this.context, this.type);

  TextStyle get getTextStyle => const TextStyle(
        fontFamily: 'Rubik',
        color: Color(0xFF2F2D2D),
        fontSize: 14,
        fontWeight: FontWeight.w400,
      );

  Color get getFillColor =>
      type == _InputType.underlined ? Colors.transparent : Colors.white;

  TextStyle get getHintStyle => type == _InputType.outlined
      ? const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 13,
          color: Color(0xFFB3B3B3),
        )
      : const TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 14,
          color: Color(0xFF898989),
        );

  TextStyle get getLabelTextStyle => type == _InputType.outlined
      ? const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 14.5,
          color: DefaultColors.grayD2,
        )
      : const TextStyle(
          fontSize: 13.5,
          fontWeight: FontWeight.w600,
          color: DefaultColors.blue9D);

  InputBorder get getBorder => type == _InputType.underlined
      ? const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFF00529B),
            width: 0.5,
          ),
        )
      : InputBorder.none;

  InputBorder get getEnabledBorder => getBorder;

  InputBorder get getFocusedBorder => getBorder;
}
