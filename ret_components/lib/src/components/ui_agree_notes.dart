import 'package:flutter/material.dart';

import '../styles/theme/colorscheme/colors/default_colors.dart';
import 'package:db_uicomponents/components.dart';

class UiAgreeNotes extends StatefulWidget {
  const UiAgreeNotes({
    super.key,
    required this.onUserAgreed,
    this.agreeNoteActive = true,
    this.openTermsAndConditions,
    this.agreed = false,
    this.text = "I have read and agree to the terms and conditions",
    this.substringIndex = 27,
  });

  final bool agreed;
  final bool agreeNoteActive;
  final ValueChanged<bool> onUserAgreed;
  final VoidCallback? openTermsAndConditions;
  final String text;
  final int substringIndex;

  @override
  State<UiAgreeNotes> createState() => _UiAgreeNotesState();
}

class _UiAgreeNotesState extends State<UiAgreeNotes> {
  bool agreed = false;

  @override
  void initState() {
    super.initState();
    agreed = widget.agreed;
  }

  onChanged(bool? checkboxValue) {
    setState(() {
      agreed = checkboxValue ?? false;
    });
    widget.onUserAgreed.call(agreed);
  }

  @override
  Widget build(BuildContext context) {

    String agreeText = widget.text.substring(0, widget.substringIndex); // "I have read and agree to the"
    String tnc = widget.text.substring(widget.substringIndex);    // " terms and conditions"
    return Row(
      children: [

        Checkbox(
            value: agreed,
            tristate: false,
            onChanged: widget.agreeNoteActive ? onChanged : null),
        Expanded(
          child: InkWell(
            onTap: widget.openTermsAndConditions,
            child: Text.rich(
              style: TextStyle(
                color: widget.agreeNoteActive ? null : Colors.grey,
                fontWeight: FontWeight.w500,
                height: 1.2,
                fontSize: 13
              ),
              TextSpan(
                text: agreeText,
                style: UiTextNew.b2Medium("").getTextStyle(context),
                children: [
                  TextSpan(
                    text: tnc,
                    style: UiTextNew.b2Medium("",color: DefaultColors.blue9D,).getTextStyle(context),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
