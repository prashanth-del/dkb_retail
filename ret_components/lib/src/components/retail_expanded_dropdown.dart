// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// import '../../db_uicomponents.dart';
//
// class DropdownExample extends StatefulWidget {
//   final List<String>? options;
//   final String? selectedValue;
//   final double? height;
//   final ValueChanged<String?>? onChanged; // Add callback
//   final String? errorMessage; // Optional error message
//
//
//   const DropdownExample({
//     super.key,
//     this.options,
//     this.selectedValue,
//     this.height,
//     this.onChanged,
//     this.errorMessage,
//
//   });
//
//   @override
//   State<DropdownExample> createState() => _DropdownExampleState();
// }
//
// class _DropdownExampleState extends State<DropdownExample> {
//   String? selectedOption;
//   late List<String> options;
//   String? error; // Holds the error message
//
//   @override
//   void initState() {
//     super.initState();
//
//     options = widget.options ??
//         [
//           "Please Select",
//           "To my own Doha Bank",
//           "Another Doha Bank",
//           "Another Local Bank",
//           "D-cardless withdrawal",
//           "This is a very long option that should wrap to the next line if needed",
//         ];
//     selectedOption = widget.selectedValue;
//     error = widget.errorMessage; // Initialize error message if provided
//
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children:[ Container(
//         height: 45,
//         padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 0),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(6.0),
//           border: Border.all(
//             color: error == null ? DefaultColors.grayE6 : Colors.red, // Red border if there's an error
//           ),
//           // boxShadow: const [
//           //   BoxShadow(
//           //     color: Colors.black12,
//           //     blurRadius: 2.0,
//           //     spreadRadius: 1.0,
//           //     offset: Offset(0, 2),
//           //   ),
//           // ],
//         ),
//         child: DropdownButtonHideUnderline(
//           child: DropdownButton<String>(
//             value: selectedOption,
//             isExpanded: true,
//             icon: Icon(Icons.keyboard_arrow_down, color: DefaultColors.blue9D, size: 30,),
//             hint: const UiTextNew.customRubik(
//               "Please Select",
//               fontSize: 14,
//               color: DefaultColors.grayB3,
//             ),
//
//             items: options.map((String value) {
//
//               if (value == "Please Select") {
//                 return DropdownMenuItem<String>(
//                   value: value,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Expanded(
//                         child: Text(
//                           value,
//                           style: const TextStyle(color: DefaultColors.grayB3,
//                              fontWeight:  FontWeight.normal
//                           ),
//                           overflow: TextOverflow.ellipsis, // Ensures long text is truncated
//                         ),
//                       ),
//                       const Icon(Icons.keyboard_arrow_up, color: DefaultColors.blue9D, size: 30,), // Up arrow icon
//                     ],
//                   ),
//                 );
//               } else {
//                 return DropdownMenuItem<String>(
//                   value: value,
//                   child: Text(
//                     value,
//                     style: const TextStyle(color: Colors.black,
//                         fontWeight: FontWeight.w500
//                     ),
//                     maxLines: null,
//                     // overflow: TextOverflow.visible, // Ensures long text is truncated
//
//                   ),
//                 );
//               }
//             }).toList(),
//             //   return DropdownMenuItem<String>(
//             //     value: value,
//             //     child: Container(
//             //       padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10), // Add padding to match UI spacing
//             //       child: Row(
//             //           children: [Text(
//             //             value,
//             //             style: TextStyle(
//             //               color: value == "Please Select"
//             //                   ? DefaultColors.grayB3
//             //                   : Colors.black,
//             //               fontWeight: value == "Please Select"
//             //                   ? FontWeight.normal
//             //                   : FontWeight.w500,
//             //             ),
//             //               maxLines: null
//             //             // overflow: TextOverflow.visible,
//             //             // softWrap: true, // Allow text to wrap
//             //           ),
//             //
//             //           ]
//             //       ),
//             //     ),
//             //   );
//             // }).toList(),
//             selectedItemBuilder: (BuildContext context) {
//               return options.map((String branch) {
//                 return Container(
//                   padding: EdgeInsets.symmetric(vertical: 10),
//                   constraints: BoxConstraints(
//                     maxWidth: double.infinity, // Allows the text to wrap
//                   ),
//                   child: Text(
//                     branch,
//                     style: TextStyle(color: Colors.black,
//                         fontWeight: FontWeight.w500
//                     ),
//                     maxLines: null, // Allows wrapping
//                     overflow: TextOverflow.ellipsis, // Ensures full visibility of text
//                   ),
//                 );
//               }).toList();
//             },
//             onChanged: (String? newValue) {
//               setState(() {
//                 if (newValue != "Please Select") {
//                   selectedOption = newValue;
//                   error = null; // Clear error if valid selection is made
//
//                 } else {
//                   selectedOption = null;
//                   error = "This field is empty."; // Set error
//       // Keep "Please Select" as default
//                 }
//                 widget.onChanged?.call(selectedOption);
//               });
//             },
//
//             dropdownColor: Colors.white,
//             borderRadius: BorderRadius.circular(5.0),
//           ),
//         ),
//       ),
//
//     if (error != null) // Show error message if exists
//       Padding(
//         padding: const EdgeInsets.only(top: 5.0),
//         child: Text(
//           error!,
//           style: TextStyle(
//             color: Colors.red,
//             fontSize: 12,
//           ),
//         ),
//       ),
//     ]
//     );
//
//   }
// }







import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../db_uicomponents.dart';

class DropdownExample extends StatefulWidget {
  final List<String>? options;
  final String? selectedValue;
  final double? height;
  final ValueChanged<String?>? onChanged;
  final String? errorMessage;

  const DropdownExample({
    super.key,
    this.options,
    this.selectedValue,
    this.height,
    this.onChanged,
    this.errorMessage,
  });

  @override
  State<DropdownExample> createState() => _DropdownExampleState();
}

class _DropdownExampleState extends State<DropdownExample> {
  String? selectedOption;
  late List<String> options;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    options = widget.options ??
        [
          "Please Select",
          "To My Own Account",
          "Other Account",
          "To Another Local Account",
          "Cardless withdrawal"
        ];
    selectedOption = widget.selectedValue;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: DropdownButtonFormField<String>(
        value: selectedOption,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 10.0,),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6.0),
            borderSide: const BorderSide(color: DefaultColors.grayE6),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6.0),
            borderSide: const BorderSide(color: DefaultColors.grayE6),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6.0),
            borderSide: const BorderSide(color: DefaultColors.grayE6),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6.0),
            borderSide: const BorderSide(color: Colors.red),
          ),
          filled: true,
          fillColor: Colors.white,
          errorStyle: const TextStyle(color: Colors.red, fontSize: 11),

        ),
        isExpanded: true,
        icon: const Icon(Icons.keyboard_arrow_down, color: DefaultColors.blue9D, size: 30),
        hint: const UiTextNew.customRubik(
          "Please Select",
          fontSize: 14,
          color: DefaultColors.grayB3,
        ),
        items: options.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: TextStyle(
                color: value == "Please Select" ? DefaultColors.grayB3 : Colors.black,
                fontWeight: value == "Please Select" ? FontWeight.normal : FontWeight.w500,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          );
        }).toList(),
        validator: (value) {
          if (value == null || value == "Please Select") {
            return "This field is required.";
          }
          return null;
        },
        onChanged: (String? newValue) {
          setState(() {
            selectedOption = newValue;
            widget.onChanged?.call(selectedOption);
            _validateForm();
          });
        },
        dropdownColor: Colors.white,
      ),
    );
  }
  void _validateForm() {
    if (_formKey.currentState?.validate() ?? false) {
      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(content: Text("Form is valid")),
      // );
    // } else {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(content: Text("Form is invalid")),
    //   );
    }
  }
}
