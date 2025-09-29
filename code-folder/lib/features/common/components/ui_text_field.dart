// import 'package:db_uicomponents/db_uicomponents.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class UiTextField extends ConsumerStatefulWidget {
//   final TextEditingController controller;
//   final String label;
//   final TextInputType keyboardType;
//   final bool obscureText;
//   final Widget? suffix;
//   final int? maxLength;
//   final ValueChanged<String>? onChanged;
//   final TextInputAction textInputAction;
//   final VoidCallback? onEditingComplete;
//   final ValueChanged<String>? onFieldSubmitted;
//   final bool autoFocus;
//   final List<TextInputFormatter>? inputFormatters;

//   const UiTextField({
//     super.key,
//     required this.controller,
//     required this.label,
//     this.keyboardType = TextInputType.text,
//     this.obscureText = false,
//     this.suffix,
//     this.maxLength,
//     this.onChanged,
//     this.textInputAction = TextInputAction.next,
//     this.onEditingComplete,
//     this.autoFocus = false,
//     this.inputFormatters,
//     this.onFieldSubmitted,
//   });

//   @override
//   ConsumerState<UiTextField> createState() => _UiTextFieldState();
// }

// class _UiTextFieldState extends ConsumerState<UiTextField> {
//   late FocusNode _focusNode;

//   @override
//   void initState() {
//     super.initState();
//     _focusNode = FocusNode();

//     if (widget.autoFocus) {
//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         _focusNode.requestFocus();
//       });
//     }

//     _focusNode.addListener(() {
//       setState(() {});
//     });
//   }

//   @override
//   void dispose() {
//     _focusNode.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 16),
//       padding: const EdgeInsets.symmetric(horizontal: 12),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(4),
//         border: Border.all(
//           color: _focusNode.hasFocus
//               ? DefaultColors.blue60
//               : DefaultColors.black,
//         ),
//       ),
//       child: TextFormField(
//         controller: widget.controller,
//         focusNode: _focusNode,
//         keyboardType: widget.keyboardType,
//         obscureText: widget.obscureText,
//         maxLength: widget.maxLength,
//         textInputAction: widget.textInputAction,
//         autofocus: widget.autoFocus,
//         inputFormatters: widget.inputFormatters,
//         onFieldSubmitted: widget.onFieldSubmitted,
//         onEditingComplete: () {
//           if (widget.onEditingComplete != null) {
//             widget.onEditingComplete!();
//           } else {
//             FocusScope.of(context).nextFocus();
//           }
//         },
//         style: const TextStyle(fontWeight: FontWeight.w600),
//         onChanged: widget.onChanged,
//         decoration: InputDecoration(
//           counterText: '',
//           label: Text(widget.label),
//           labelStyle: const TextStyle(
//             fontSize: 14,
//             color: DefaultColors.black,
//             fontWeight: FontWeight.w500,
//           ),
//           border: InputBorder.none,
//           suffix: widget.suffix,
//         ),
//       ),
//     );
//   }
// }

//  // Container(
//                 //   margin: EdgeInsets.symmetric(horizontal: 16),
//                 //   padding: EdgeInsets.symmetric(horizontal: 12),
//                 //   decoration: BoxDecoration(
//                 //     borderRadius: BorderRadius.circular(4),
//                 //     border: Border.all(
//                 //       color: cardNode.hasFocus
//                 //           ? DefaultColors.blue60
//                 //           : DefaultColors.black,
//                 //     ),
//                 //   ),
//                 //   child: TextFormField(
//                 //     onTap: () {
//                 //       FocusScope.of(context).requestFocus(cardNode);
//                 //     },
//                 //     maxLength: 16,

//                 //     controller: cardController,
//                 //     focusNode: cardNode,
//                 //     keyboardType: TextInputType.numberWithOptions(),
//                 //     style: TextStyle(fontWeight: FontWeight.w600),
//                 //     inputFormatters: [
//                 //       FilteringTextInputFormatter.allow(
//                 //         RegExp(r'[0-9]'),
//                 //       ), // Allow only digits
//                 //     ],
//                 //     onChanged: (value) async {
//                 //       if (value.length == 16) {
//                 //         ref.read(isVisibleProvider.notifier).state = true;
//                 //         WidgetsBinding.instance.addPostFrameCallback((_) {
//                 //           FocusScope.of(context).requestFocus(pinNode);
//                 //         });
//                 //         await Future.delayed(Duration(milliseconds: 100), () {
//                 //           setState(() {});
//                 //         });
//                 //       } else {
//                 //         ref.read(isVisibleProvider.notifier).state = false;
//                 //       }
//                 //     },
//                 //     decoration: InputDecoration(
//                 //       counterText: '',
//                 //       label: Text('Enter debit/perpaid card number'),
//                 //       labelStyle: TextStyle(
//                 //         fontSize: 14,
//                 //         color: DefaultColors.black,
//                 //         fontWeight: FontWeight.w500,
//                 //       ),
//                 //       border: InputBorder.none,
//                 //     ),
//                 //   ),
//                 // ),