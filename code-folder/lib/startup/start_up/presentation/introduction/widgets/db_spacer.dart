import 'package:flutter/material.dart';

enum SpacerType { horizontal, vertical }

class DbSpacer extends StatelessWidget {
  const DbSpacer({
    this.type = SpacerType.vertical,
    this.height = 16,
    this.width = 16,
    super.key,
  });

  final SpacerType type;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: type == SpacerType.vertical ? height : 0,
      width: type == SpacerType.horizontal ? width : 0,
    );
  }
}