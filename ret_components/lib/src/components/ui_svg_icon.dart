import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UISvgIcon extends StatelessWidget {
  final String assetPath;
  final double? width;
  final double? height;
  final BoxFit fit;
  final VoidCallback? onTap;
  final Color? color;

  const UISvgIcon({
    Key? key,
    required this.assetPath,
    this.onTap,
    this.color,
    this.width, // Default width if not provided
    this.height, // Default height if not provided
    this.fit = BoxFit.contain, // Default BoxFit if not provided
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: width,
        height: height,
        child: SvgPicture.asset(
          assetPath,
          fit: fit,
          color: color,
        ),
      ),
    );
  }
}
