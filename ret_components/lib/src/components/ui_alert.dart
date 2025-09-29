import 'package:db_uicomponents/components.dart';
import 'package:db_uicomponents/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum AlertType { error, info }

class UIAlert extends StatelessWidget {
  final String message;
  final AlertType type;
  final AlignmentGeometry position;
  final Widget? content;

  const UIAlert.error({
    super.key,
    required this.message,
    this.position = Alignment.bottomCenter,
  })  : type = AlertType.error,
        content = null;

  const UIAlert.info({
    super.key,
    required this.message,
    this.content,
    this.position = Alignment.bottomCenter,
  }) : type = AlertType.info;

  @override
  Widget build(BuildContext context) {
    final styles = _UIAlertStyles(type, message);

    return Align(
      alignment: position,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(4)),
          color: styles.getBackgroundColor(),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: _buildAlertContent(styles),
      ),
    );
  }

  Widget _buildAlertContent(_UIAlertStyles styles) {
    switch (type) {
      case AlertType.error:
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            styles.getIcon(),
            const SizedBox(width: 10),
            Flexible(child: styles.getText()),
          ],
        );
      case AlertType.info:
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                styles.getIcon(),
                const SizedBox(width: 8),
                styles.getText(),
              ],
            ),
            if (content != null)
              SizedBox(
                height: 4,
              ),
            if (content != null)
              Padding(
                padding: EdgeInsets.only(left: 5),
                child: content!,
              ),
          ],
        );
    }
  }
}

class _UIAlertStyles {
  final AlertType type;
  final String message;

  _UIAlertStyles(this.type, this.message);

  Color getBackgroundColor() {
    switch (type) {
      case AlertType.error:
        return DefaultColors.red_42;
      case AlertType.info:
        return DefaultColors.yellow48;
    }
  }

   getText() {
    switch (type) {
      case AlertType.error:
        return Text(
          message,
          style: const TextStyle(
            color: DefaultColors.red_09,
            fontSize: 11,
            fontWeight: FontWeight.normal,
          ),
        );
      case AlertType.info:
        return UiTextNew.b2Semibold(message, color: DefaultColors.black32,);
    }
  }

  Widget getIcon() {
    switch (type) {
      case AlertType.error:
        return const Icon(
          Icons.error,
          color: DefaultColors.red_09,
        );
      case AlertType.info:
        return SvgPicture.asset("assets/icons/info.svg");
    }
  }
}
