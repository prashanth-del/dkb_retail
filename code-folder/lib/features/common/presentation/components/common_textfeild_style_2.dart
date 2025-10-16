import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFieldStyle2 extends StatelessWidget {
  final String label;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final bool obscureText;
  final bool enabled;
  final Color? cursorColor;
  final TextStyle? textStyle;
  final TextStyle? labelStyle;
  final TextStyle? floatingLabelStyle;
  final FloatingLabelBehavior floatingLabelBehavior;
  final Color? fillColor;
  final EdgeInsetsGeometry? contentPadding;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final Widget? suffixIcon;
  final int? maxLines;
  final int? minLines;
  final double? borderRadius;
  final Function(String)? onChanged;
  final Function()? onTap;
  final bool allowCopyPaste;

  const CustomTextFieldStyle2({
    super.key,
    required this.label,
    this.controller,
    this.keyboardType,
    this.textInputAction,
    this.inputFormatters,
    this.obscureText = false,
    this.enabled = true,
    this.cursorColor,
    this.textStyle,
    this.labelStyle,
    this.floatingLabelStyle,
    this.floatingLabelBehavior = FloatingLabelBehavior.auto,
    this.fillColor,
    this.contentPadding,
    this.enabledBorder,
    this.focusedBorder,
    this.suffixIcon,
    this.maxLines = 1,
    this.minLines,
    this.borderRadius = 8.0,
    this.onChanged,
    this.onTap,
    this.allowCopyPaste = true,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      inputFormatters: inputFormatters,
      obscureText: obscureText,
      enabled: enabled,
      cursorColor: cursorColor ?? Colors.white,
      style:
          textStyle ??
          const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.normal,
            fontSize: 18,
          ),
      maxLines: maxLines,
      minLines: minLines,
      onChanged: onChanged,
      onTap: onTap,

      // 🧩 Disable copy/paste context menu if allowCopyPaste == false
      contextMenuBuilder: allowCopyPaste
          ? null // default menu behavior
          : (context, editableTextState) => const SizedBox.shrink(),

      decoration: InputDecoration(
        labelText: label,
        floatingLabelStyle:
            floatingLabelStyle ??
            TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.normal,
              fontSize: size.aspectRatio * 40,
            ),
        labelStyle:
            labelStyle ??
            TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.normal,
              fontSize: size.aspectRatio * 30,
            ),
        floatingLabelBehavior: floatingLabelBehavior,
        filled: true,
        fillColor: fillColor ?? Colors.transparent,
        contentPadding:
            contentPadding ??
            EdgeInsets.symmetric(
              vertical: size.height * 0.0175,
              horizontal: size.width * 0.025,
            ),
        enabledBorder:
            enabledBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius!),
              borderSide: const BorderSide(color: Colors.white, width: 0.7),
            ),
        focusedBorder:
            focusedBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius!),
              borderSide: const BorderSide(color: Colors.white, width: 0.7),
            ),
        suffixIcon: suffixIcon,
      ),
    );
  }
}
