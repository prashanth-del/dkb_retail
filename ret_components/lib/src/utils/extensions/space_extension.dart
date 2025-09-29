import 'package:db_uicomponents/components.dart';
import 'package:flutter/material.dart';

extension SpaceX on Widget {
  Widget vertical(double space) {
    return Column(
      children: [this, UiSpace.vertical(space)],
    );
  }

  Widget horizontal(double space) {
    return Column(
      children: [this, UiSpace.horizontal(space)],
    );
  }
}
