import 'dart:ui';

import 'package:db_uicomponents/components.dart';
import 'package:db_uicomponents/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum _InputType {
  outlined,
  underlined,
}

class UIFormTextField extends StatefulWidget {
  final String hintText;
  final TextEditingController? controller;
  final String? initialValue;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool obscure;
  final FocusNode? focus;
  final TextStyle? textStyle;
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
  final Color? borderColor;
  final double? cornerEdge;
  final TextAlignVertical? textAlignVertical;
  final bool revealObscuredOnLongPress;
  final EdgeInsets contentPadding;
  final String? label;
  final bool? showBoxShadow;
  final bool filled;
  final UiTextNew? labelUiText;
  final TextStyle? labelHintTextStyle;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;
  final TextStyle? labelTextStyle;

  const UIFormTextField.outlined({
    required this.hintText,
    this.helperText,
    this.controller,
    this.initialValue,
    this.labelUiText,
    this.inputFormatters,
    this.suffixIcon,
    this.prefixIcon,
    this.obscure = false,
    this.onTap,
    this.focus,
    this.textStyle,
    this.cornerEdge,
    this.borderColor,
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
        const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
    this.label,
    this.showBoxShadow,
    this.filled = true,
    this.maxLength = 50,
    this.labelTextStyle,
    this.labelHintTextStyle,
    super.key,
  }) : _inputType = _InputType.outlined;

  const UIFormTextField.underlined({
    required this.hintText,
    this.helperText,
    this.labelUiText,
    this.controller,
    this.initialValue,
    this.textStyle,
    this.suffixIcon,
    this.inputFormatters,
    this.prefixIcon,
    this.obscure = false,
    this.onTap,
    this.focus,
    this.cornerEdge,
    this.borderColor,
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
    this.contentPadding =
        const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
    this.label,
    this.showBoxShadow,
    this.filled = true,
    this.maxLength = 50,
    this.labelTextStyle,
    this.labelHintTextStyle,

    super.key,
  }) : _inputType = _InputType.underlined;

  final _InputType _inputType;

  @override
  State<UIFormTextField> createState() => _UIInputFieldState();
}

class _UIInputFieldState extends State<UIFormTextField> {
  bool revealText = false;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focus ?? FocusNode();
  }

  void _handleFieldSubmitted(String value) {
    if (widget.onFieldSubmitted != null) {
      widget.onFieldSubmitted?.call(value);
    } else {
      FocusScope.of(context).unfocus(); // Dismiss keyboard
    }
  }

  @override
  Widget build(BuildContext context) {
    TextDirection textDirection = Directionality.of(context);
    final inputFieldStyles = _UIInputFieldStyles(
        context, widget._inputType, widget.cornerEdge, widget.borderColor,widget.labelTextStyle, widget.labelHintTextStyle);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0, left: 0),
            child: inputFieldStyles.getLabelTextStyle(widget.label!),
          ),
        if (widget.label == null && widget.labelUiText != null)
          Padding(
            padding: EdgeInsets.only(bottom: 4, left: 2),
            child: widget.labelUiText!,
          ),
        TextFormField(
          focusNode: _focusNode,
          controller: widget.controller,
          // enableInteractiveSelection: false,
          maxLength: widget.maxLength,
          contextMenuBuilder:
              (BuildContext context, EditableTextState editableTextState) =>
                  _ContextMenuBuilder().build(context, editableTextState),
          textAlignVertical: widget.textAlignVertical,
          autofocus: widget.autofocus,
          keyboardType: widget.textInputType,
          textInputAction: widget.textInputAction,
          readOnly: widget.readOnly,
          textDirection: TextDirection.ltr,
          textAlign: textDirection == TextDirection.ltr
              ? TextAlign.left
              : TextAlign.right,
          onChanged: widget.onChanged,
          onEditingComplete: widget.onEditDone ?? () {},
          onTap: () async {
            _focusNode.unfocus();
            _focusNode.requestFocus();
            widget.onTap?.call();
          },
          onFieldSubmitted: _handleFieldSubmitted,
          validator: widget.validator,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          initialValue: widget.initialValue,
          inputFormatters: widget.inputFormatters,
          style: widget.textStyle ?? inputFieldStyles.getTextStyle,
          cursorColor: widget._inputType == _InputType.outlined
              ? const Color(0xFFC6E2FA)
              : const Color(0xFF113E98),
          obscureText: widget.obscure && !revealText,
          decoration: InputDecoration(
            counterText: '',
            contentPadding: widget.contentPadding,
            filled: widget.filled,
            isDense: true,
            fillColor: inputFieldStyles.getFillColor,
            hintText: widget.hintText,
            suffixIconConstraints: BoxConstraints(),
            hintStyle: inputFieldStyles.getHintStyle,
            errorStyle: inputFieldStyles.getErrorStyle,
            border: inputFieldStyles.getBorder,
            enabledBorder: inputFieldStyles.getEnabledBorder,
            focusedBorder: inputFieldStyles.getFocusedBorder,
            errorBorder: inputFieldStyles.getErrorBorder,
            prefixIcon: widget.prefixIcon,
            // prefixIconConstraints: const BoxConstraints(maxWidth: 40),
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
    );
  }
}

class _UIInputFieldStyles {
  final BuildContext context;
  final _InputType type;
  final double? edge;
  final Color? borderColor;
  final TextStyle? labelTextStyle;
  final TextStyle? labelHintTextStyle;

  _UIInputFieldStyles(this.context, this.type, this.edge, this.borderColor, this.labelTextStyle, this.labelHintTextStyle);

  TextStyle get getTextStyle => type == _InputType.outlined
      ? labelTextStyle ?? TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 16,
          color: DefaultColors.blue9B,
        )
      : labelTextStyle ?? TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 14,
          color: DefaultColors.blue9B,
        );

  Color get getFillColor =>
      type == _InputType.underlined ? Colors.transparent : Colors.white;

  TextStyle get getErrorStyle => const TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 10,
        color: DefaultColors.red_09,
      );

  TextStyle get getHintStyle => type == _InputType.outlined
      ? labelHintTextStyle ?? const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 13,
          color: Color(0xFF898989),
        )
      : labelHintTextStyle ?? const TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 14,
          color: Color(0xFF898989),
        );

  getLabelTextStyle(String text) => type == _InputType.outlined
      ? UiTextNew.b1Semibold(text)
      : UiTextNew.b2Semibold(text, color: DefaultColors.blue9C);

  InputBorder get getBorder => type == _InputType.underlined
      ? UnderlineInputBorder(
          borderSide: BorderSide(
            color: borderColor ?? Color(0xFF00529B),
            width: 1,
          ),
        )
      : OutlineInputBorder(
          borderRadius: BorderRadius.circular(edge ?? 10), // Rounded corners
          borderSide: BorderSide(color: borderColor ?? DefaultColors.greyBorder),
        );

  InputBorder get getErrorBorder => type == _InputType.underlined
      ? const UnderlineInputBorder(
          borderSide: BorderSide(
            color: DefaultColors.red_09,
            width: 0.5,
          ),
        )
      : OutlineInputBorder(
          borderRadius: BorderRadius.circular(edge ?? 10), // Rounded corners
          borderSide: const BorderSide(color: DefaultColors.red_09),
        );

  InputBorder get getEnabledBorder => getBorder;

  InputBorder get getFocusedBorder => getBorder;
}

class _ContextMenuBuilder {
  build(BuildContext context, EditableTextState editableTextState) {
    final List<ContextMenuButtonItem> buttonItems =
        editableTextState.contextMenuButtonItems;

    // Define a set of button types to remove
    final Set<ContextMenuButtonType> typesToRemove = {
      ContextMenuButtonType.copy,
      ContextMenuButtonType.paste,
      ContextMenuButtonType.cut,
      ContextMenuButtonType.share,
      ContextMenuButtonType.selectAll,
    };

    // Remove the buttons that are in the typesToRemove set
    buttonItems.removeWhere((ContextMenuButtonItem buttonItem) =>
        typesToRemove.contains(buttonItem.type));

    return AdaptiveTextSelectionToolbar.buttonItems(
      anchors: editableTextState.contextMenuAnchors,
      buttonItems: buttonItems,
    );
  }
}
