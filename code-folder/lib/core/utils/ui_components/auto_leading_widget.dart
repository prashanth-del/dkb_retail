import 'package:db_uicomponents/components.dart';
import 'package:dkb_retail/core/constants/colors.dart';
import 'package:flutter/material.dart';

class LeadingWidget extends StatefulWidget {
  final String title;
  void Function()? onTap;
  LeadingWidget({super.key, required this.title, this.onTap});

  @override
  State<LeadingWidget> createState() => _AutoLeadingWidgetState();
}

class _AutoLeadingWidgetState extends State<LeadingWidget> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            widget.onTap ?? Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios_sharp,
            size: 20,
            color: DefaultColors.black.withOpacity(0.8),
          ),
          // SvgPicture.asset(
          //   "assets/images/locate_image/Buttons.svg",
          //   width: 40,
          //   height: 40,
          //   fit: BoxFit.cover,
          // ),
        ),

        SizedBox(width: size.width * 0.04),
        UiTextNew.custom(
          widget.title,
          color: DefaultColors.blueBase,
          fontWeight: FontWeight.w600,
          fontSize: 16,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
