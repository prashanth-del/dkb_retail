import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UiTextField extends ConsumerStatefulWidget {
  final TextEditingController? controller;
  final String label;
  final TextInputType keyboardType;
  final String? hintText;
  final bool obscureText;
  final FocusNode? focusNode;
  final Widget? suffix;
  final Widget? prefix;
  final int? maxLength;
  final Color? unfocusBorderColor;
  final Color? focusBorderColor;
  final Color? hintTextColor;
  final Color? cursorColor;
  final ValueChanged<String>? onChanged;
  final TextInputAction textInputAction;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onFieldSubmitted;
  final bool autoFocus;
  final EdgeInsetsGeometry? margin;
  final bool isReadOnly;
  final EdgeInsetsGeometry? padding;
  final List<TextInputFormatter>? inputFormatters;
  final void Function()? onTap;
  final FormFieldValidator<String>? validator;
  final bool allowCopyPaste;

  const UiTextField({
    super.key,
    this.controller,
    required this.label,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.isReadOnly = false,
    this.allowCopyPaste = true,
    this.suffix,
    this.prefix,
    this.focusBorderColor,
    this.focusNode,
    this.cursorColor,
    this.unfocusBorderColor,
    this.hintTextColor,
    this.maxLength,
    this.onChanged,
    this.margin,
    this.hintText,
    this.padding,
    this.textInputAction = TextInputAction.next,
    this.onEditingComplete,
    this.autoFocus = false,
    this.inputFormatters,
    this.onFieldSubmitted,
    this.onTap,
    this.validator,
  });

  @override
  ConsumerState<UiTextField> createState() => _UiTextFieldState();
}

class _UiTextFieldState extends ConsumerState<UiTextField> {
  late FocusNode _focusNode;
  bool _ownsFocusNode = false;

  @override
  void initState() {
    super.initState();

    // If no external FocusNode is provided, create one internally.
    if (widget.focusNode == null) {
      _focusNode = FocusNode();
      _ownsFocusNode = true;
    } else {
      _focusNode = widget.focusNode!;
    }

    if (widget.autoFocus) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _focusNode.requestFocus();
      });
    }

    _focusNode.addListener(() {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    // ✅ Only dispose if we created it
    if (_ownsFocusNode) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      validator: widget.validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      builder: (field) {
        final hasError = field.errorText != null;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin:
                  widget.margin ?? const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(1),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                gradient: widget.focusBorderColor == null
                    ? widget.isReadOnly
                        ? null
                        : hasError
                            ? null
                            : _focusNode.hasFocus
                                ? const LinearGradient(colors: [
                                    Color(0xff4197CB),
                                    Color(0xff15954B),
                                  ])
                                : null
                    : null,
              ),
              child: Container(
                padding: widget.padding ??
                    EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.01,
                    ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  gradient: widget.focusBorderColor == null
                      ? widget.isReadOnly
                          ? null
                          : _focusNode.hasFocus
                              ? const LinearGradient(colors: [
                                  Color(0xffECF8FF),
                                  Color(0xffEBFFF8),
                                ])
                              : null
                      : null,
                  border: Border.all(
                    color: widget.isReadOnly
                        ? DefaultColors.greyBorder
                        : hasError
                            ? context.colorScheme.error
                            : _focusNode.hasFocus
                                ? widget.focusBorderColor ?? Colors.transparent
                                : widget.unfocusBorderColor ??
                                    DefaultColors.greyBorder,
                  ),
                ),
                child: TextFormField(
                  readOnly: widget.isReadOnly,
                  controller: widget.controller,
                  focusNode: _focusNode,
                  cursorColor: widget.cursorColor ?? Colors.black,
                  keyboardType: widget.keyboardType,
                  obscureText: widget.obscureText,
                  maxLength: widget.maxLength,
                  textInputAction: widget.textInputAction,
                  autofocus: widget.autoFocus,
                  inputFormatters: widget.inputFormatters,
                  onFieldSubmitted: widget.onFieldSubmitted,
                  contextMenuBuilder: widget.allowCopyPaste
                      ? null
                      // default menu behavior
                      : (context, editableTextState) => const SizedBox.shrink(),
                  onEditingComplete: () {
                    if (widget.onEditingComplete != null) {
                      widget.onEditingComplete!();
                    } else {
                      FocusScope.of(context).nextFocus();
                    }
                  },
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: widget.hintTextColor ?? DefaultColors.black,
                    fontSize: 14,
                    fontFamily: "DiodrumArabic",
                  ),
                  onChanged: (val) {
                    field.didChange(val);
                    widget.onChanged?.call(val);
                  },
                  onTap: widget.onTap,
                  decoration: InputDecoration(
                    counterText: '',
                    hintText: widget.hintText,
                    labelText: widget.label,
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    labelStyle: TextStyle(
                      fontFamily: "DiodrumArabic",
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: hasError
                          ? context.colorScheme.error
                          : widget.hintTextColor ?? DefaultColors.greyBorder,
                    ),
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    suffixIcon: widget.suffix,
                    prefix: widget.prefix,
                  ),
                ),
              ),
            ),
            if (hasError)
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 4),
                child: Text(
                  field.errorText!,
                  style: TextStyle(
                    color: context.colorScheme.error,
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
