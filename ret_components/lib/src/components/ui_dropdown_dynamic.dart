import 'package:db_uicomponents/components.dart';
import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:flutter/material.dart';

class UiDropdownDynamic<T> extends StatelessWidget {
  final String? label;
  final FocusNode? focusNode;
  final List<T> items;
  final Function(T? value)? onChanged;
  final Widget Function(T item) itemBuilder;
  final T? value;
  final String hint;
  const UiDropdownDynamic(
      {super.key,
        this.label,
        this.focusNode,
        required this.items,
        required this.onChanged,
        required this.value,
        required this.itemBuilder,
        required this.hint});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Padding(
            padding: const EdgeInsets.only(left: 5, bottom: 10),
            child: UiTextNew.h4Medium(
              '$label',
            ),
          ),
        SizedBox(
          height: 50,
          child: DropdownButtonHideUnderline(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(8), border: Border.all(
                color: const Color(0xFF00539D).withOpacity(0.2),
              ),),
              child: Padding(
                padding: const EdgeInsets.only(left: 0, right: 20),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: DropdownButton(
                    autofocus: true,
                    focusNode: focusNode,
                    isExpanded: true,
                    hint: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: UiTextNew.b2Regular(
                        hint, color: const Color(0xFF898989),
                      ),
                    ),
                    icon: const Icon(
                      Icons.keyboard_arrow_down,
                      color: Color(0xFF00529B),
                      size: 25.0,
                    ),
                    style: const UiTextNew.b15Medium("").getTextStyle(context),
                    items: items.map((item) {
                      return DropdownMenuItem(
                        value: item,
                        child: itemBuilder(item),
                      );
                    }).toList(),
                    onChanged: onChanged,
                    value: value,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
