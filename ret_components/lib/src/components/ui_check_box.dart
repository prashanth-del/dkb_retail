import 'package:flutter/material.dart';
import '../../db_uicomponents.dart';

class UICheckBox extends StatelessWidget {
  final CheckBoxState checkBox;
  final void Function(bool?)? onTap;
  const UICheckBox({
    super.key,
    required this.checkBox,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      contentPadding: EdgeInsets.zero,
      controlAffinity: ListTileControlAffinity.leading,
      activeColor: DefaultColors.blue9C,
      value: checkBox.value,
      title: Text(
        checkBox.title,
        style: context.textTheme.bodyMedium,
      ),
      onChanged: onTap,
    );
  }
}

class CheckBoxState {
  final String title;
  bool value;

  CheckBoxState({
    required this.title,
    this.value = false
  });
}
