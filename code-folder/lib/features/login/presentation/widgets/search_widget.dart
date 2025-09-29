import 'package:db_uicomponents/components.dart';
import 'package:dkb_retail/core/constants/colors.dart';
import 'package:flutter/material.dart';

class SearchTextFilled extends StatefulWidget {
  const SearchTextFilled({
    this.controller,
    this.onFieldSubmitted,
    this.isSuffixIcon = true,
    this.hintText,
    this.onChanged,
    this.autofocus,
    this.onTap,
    this.isReadeOnly,
    this.hintColor,
    this.isPrefixIcon = true,
    this.fillColor,
    this.prefixIconWidget,
    this.borderColor,
    this.suffixIconWidget,
    this.height,
    this.onFinish,
    this.textInputType,
    this.textInputAction,
  });
  final TextEditingController? controller;
  final bool? isSuffixIcon;
  final Color? hintColor;

  final Function(String)? onChanged;
  final bool? isPrefixIcon;
  final String? hintText;
  final bool? isReadeOnly;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final Color? fillColor;
  final Color? borderColor;
  final void Function()? onFinish;
  final double? height;
  final ValueChanged<String>? onFieldSubmitted;

  final GestureTapCallback? onTap;
  final Widget? suffixIconWidget;
  final Widget? prefixIconWidget;

  final bool? autofocus;

  @override
  _SearchTextFilledState createState() => _SearchTextFilledState();
}

class _SearchTextFilledState extends State<SearchTextFilled> {
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height ?? 40,
      child: Stack(
        alignment: Alignment.center,
        children: [
          TextFormField(
            controller: widget.controller,
            focusNode: _focusNode, // 👈 add focus node
            style: const TextStyle(
              color: DefaultColors.black,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
            keyboardType: widget.textInputType ?? TextInputType.text,
            textInputAction: widget.textInputAction ?? TextInputAction.go,
            autofocus: widget.autofocus ?? false,
            onChanged: widget.onChanged,
            readOnly: widget.isReadeOnly ?? false,
            onTap: widget.onTap,
            decoration: InputDecoration(
              filled: true,
              fillColor: widget.fillColor ?? Colors.white,
              contentPadding: const EdgeInsets.symmetric(
                vertical: 2,
                horizontal: 12,
              ),
              hintText: "", // hide default hint
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(80),
                borderSide: BorderSide(
                  color: widget.borderColor ?? DefaultColors.grayMedBase,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(80),
                borderSide: BorderSide(
                  color: widget.borderColor ?? DefaultColors.grayMedBase,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(80),
                borderSide: BorderSide(
                  color: widget.borderColor ?? DefaultColors.grayMedBase,
                ),
              ),
            ),
          ),

          // overlay only when empty
          if ((widget.controller?.text.isEmpty ?? true))
            GestureDetector(
              onTap: () {
                _focusNode.requestFocus(); // 👈 force focus → keyboard opens
              },
              behavior: HitTestBehavior.translucent,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.search,
                    color: DefaultColors.black,
                    size: 22,
                  ),
                  const SizedBox(width: 6),
                  UiTextNew.customRubik(
                    widget.hintText ?? "Search",
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: DefaultColors.grayBase,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
