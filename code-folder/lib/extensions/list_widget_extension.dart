import 'package:flutter/widgets.dart';

extension InBetweenForListWidgets on List<Widget> {
  List<Widget> dashBetween(Widget dashContainer) => expand(
        (element) sync* {
      yield dashContainer;
      yield element;
    },
  ).skip(1).toList();

  List<Widget> spacerTillEnd(SizedBox sizedBox) => expand(
        (Widget child) sync* {
      yield child;
      yield sizedBox;
    },
  ).toList();

  List<Widget> spacer(SizedBox sizedBox) => expand(
        (Widget child) sync* {
      yield sizedBox;
      yield child;
    },
  ).skip(1).toList();
}