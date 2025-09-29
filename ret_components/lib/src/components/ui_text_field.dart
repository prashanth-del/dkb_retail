import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//
// class UiTextField extends ConsumerStatefulWidget {
//   final TextEditingController controller;
//   final String label;
//   final TextInputType keyboardType;
//   final bool obscureText;
//   final Widget? suffix;
//   final int? maxLength;
//   final Color? unfocusBorderColor;
//   final Color? focusBorderColor;
//   final Color? hintTextColor;
//   final ValueChanged<String>? onChanged;
//   final TextInputAction textInputAction;
//   final VoidCallback? onEditingComplete;
//   final ValueChanged<String>? onFieldSubmitted;
//   final bool autoFocus;
//   final EdgeInsetsGeometry? margin;
//   final bool? isReadOnly;
//   final EdgeInsetsGeometry? padding;
//   final List<TextInputFormatter>? inputFormatters;
//   final void Function()? onTap;
//   final String? errorText; // 👈 Added errorText
//
//   const UiTextField({
//     super.key,
//     required this.controller,
//     required this.label,
//     this.keyboardType = TextInputType.text,
//     this.obscureText = false,
//     this.isReadOnly,
//     this.suffix,
//     this.focusBorderColor,
//     this.unfocusBorderColor,
//     this.hintTextColor,
//     this.maxLength,
//     this.onChanged,
//     this.margin,
//     this.padding,
//     this.textInputAction = TextInputAction.next,
//     this.onEditingComplete,
//     this.autoFocus = false,
//     this.inputFormatters,
//     this.onFieldSubmitted,
//     this.onTap,
//     this.errorText, // 👈 include errorText in constructor
//   });
//
//   @override
//   ConsumerState<UiTextField> createState() => _UiTextFieldState();
// }
//
// class _UiTextFieldState extends ConsumerState<UiTextField> {
//   late FocusNode _focusNode;
//
//   @override
//   void initState() {
//     super.initState();
//     _focusNode = FocusNode();
//
//     if (widget.autoFocus) {
//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         _focusNode.requestFocus();
//       });
//     }
//
//     _focusNode.addListener(() {
//       setState(() {});
//     });
//   }
//
//   @override
//   void dispose() {
//     _focusNode.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final hasError = widget.errorText != null && widget.errorText!.isNotEmpty;
//
//     return Container(
//       margin: widget.margin ?? const EdgeInsets.symmetric(horizontal: 16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             padding:
//                 widget.padding ?? const EdgeInsets.symmetric(horizontal: 12),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10),
//               border: Border.all(
//                 color: hasError
//                     ? DefaultColors.redDB // 👈 red border on error
//                     : _focusNode.hasFocus
//                         ? widget.focusBorderColor ?? DefaultColors.blue60
//                         : widget.unfocusBorderColor ?? DefaultColors.greyBorder,
//               ),
//             ),
//             child: TextFormField(
//               readOnly: widget.isReadOnly ?? false,
//               controller: widget.controller,
//               focusNode: _focusNode,
//               keyboardType: widget.keyboardType,
//               obscureText: widget.obscureText,
//               maxLength: widget.maxLength,
//               textInputAction: widget.textInputAction,
//               autofocus: widget.autoFocus,
//               inputFormatters: widget.inputFormatters,
//               onFieldSubmitted: widget.onFieldSubmitted,
//               onEditingComplete: () {
//                 if (widget.onEditingComplete != null) {
//                   widget.onEditingComplete!();
//                 } else {
//                   FocusScope.of(context).nextFocus();
//                 }
//               },
//               style: TextStyle(
//                 fontWeight: FontWeight.w700,
//                 color: widget.hintTextColor ?? DefaultColors.black,
//                 fontSize: 12,
//               ),
//               onChanged: widget.onChanged,
//               onTap: widget.onTap,
//               decoration: InputDecoration(
//                 counterText: '',
//                 labelText: widget.label,
//                 floatingLabelBehavior: FloatingLabelBehavior.auto,
//                 labelStyle: TextStyle(
//                   fontSize: 12,
//                   color: widget.hintTextColor ?? DefaultColors.greyBorder,
//                   fontWeight: FontWeight.w600,
//                 ),
//                 border: InputBorder.none,
//                 enabledBorder: InputBorder.none,
//                 focusedBorder: InputBorder.none,
//                 errorBorder: InputBorder.none,
//                 disabledBorder: InputBorder.none,
//                 suffixIcon: widget.suffix,
//               ),
//             ),
//           ),
//           if (hasError) ...[
//             const SizedBox(height: 4),
//             Text(
//               widget.errorText!,
//               style: const TextStyle(
//                 fontSize: 11,
//                 color: DefaultColors.redDB,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ],
//         ],
//       ),
//     );
//   }
// }
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

  const UiTextField({
    super.key,
    this.controller,
    required this.label,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.isReadOnly = false,
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

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    if (widget.autoFocus) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _focusNode.requestFocus();
      });
    }
    _focusNode.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _focusNode.dispose();
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
              padding: widget.padding ??
                  EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.01),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: widget.isReadOnly
                      ? DefaultColors.greyBorder
                      : hasError
                          ? context.colorScheme.error
                          : _focusNode.hasFocus
                              ? widget.focusBorderColor ?? DefaultColors.blue60
                              : widget.unfocusBorderColor ??
                                  DefaultColors.greyBorder,
                ),
              ),
              child: TextFormField(
                readOnly: widget.isReadOnly ?? false,
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
                    fontFamily: "DiodrumArabic"),
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
                    prefix: widget.prefix),
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
