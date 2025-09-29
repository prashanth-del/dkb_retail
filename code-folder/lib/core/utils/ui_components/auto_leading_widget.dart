import 'package:db_uicomponents/components.dart';
import 'package:dkb_retail/core/constants/colors.dart';
import 'package:flutter/material.dart';

class LeadingWidget extends StatefulWidget {
  final String title;
  const LeadingWidget({super.key, required this.title});

  @override
  State<LeadingWidget> createState() => _AutoLeadingWidgetState();
}

class _AutoLeadingWidgetState extends State<LeadingWidget> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final dynamicHeight = size.height * 0.08; // ~8% of screen height
    final iconSize = size.width * 0.03;
    final horizontalPadding = size.width * 0.04; // dynamic padding
    final fontSize = size.width * 0.045;
    return Row(
      children: [
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            padding: EdgeInsets.all(size.width * 0.01),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: DefaultColors.black25.withAlpha(60)),
            ),
            child: Icon(
              Icons.arrow_back_ios_new,
              size: iconSize,
              color: DefaultColors.blue98,
            ),
          ),
          // SvgPicture.asset(
          //   "assets/images/locate_image/Back.svg",
          //   width: 24,
          //   height: 24,
          // ),
        ),
        SizedBox(width: size.width * 0.02),
        UiTextNew.custom(
          widget.title,
          color: DefaultColors.blueBase,
          fontWeight: FontWeight.w700,
          fontSize: 15,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
