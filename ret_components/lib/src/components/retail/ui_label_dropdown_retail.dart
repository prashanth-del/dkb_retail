import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../db_uicomponents.dart';

class UiLabelDropdownRetail extends StatelessWidget {
  final String label;
  final List<String>? options;
  final String? selectedValue;
  final ValueChanged<String?>? onChanged; // Add callback

  const UiLabelDropdownRetail({super.key,
    required this.label,
    this.options,
    this.selectedValue,
    this.onChanged,

  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        UiTextNew.h4Regular(
          label,
          color: DefaultColors.white_800,
        ),
        const SizedBox(height: 8,),
        DropdownExample(
          options: options ?? [],

          selectedValue: selectedValue,
          onChanged: onChanged,
        )

      ],
    );
  }
}
