import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../db_uicomponents.dart';

class UiHeaderSubHeaderRetail extends StatelessWidget {
  final String title;
  final String? description;
  final TextAlign? alignment;

  const UiHeaderSubHeaderRetail({super.key,
    required this.title,
     this.description,
    this.alignment,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        UiTextNew.customRubik(
          title,
          fontSize: 18,
          textAlign: alignment ?? TextAlign.left,
          color: DefaultColors.black,
        ),
        const SizedBox(height: 8,),
        if(description != null)
        UiTextNew.h4Regular(
          description ?? "",
          textAlign: alignment ?? TextAlign.left,
          color: DefaultColors.white_800,
        ),

      ],
    );
  }
}
