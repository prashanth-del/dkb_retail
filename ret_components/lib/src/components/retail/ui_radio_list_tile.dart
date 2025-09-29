
import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:flutter/material.dart';

class AccountOption {
  final String title;
  final String description;

  AccountOption({required this.title, required this.description});
}

class AccountSelector extends StatelessWidget {
  final List<AccountOption> options;
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  const AccountSelector({
    Key? key,
    required this.options,
    required this.selectedIndex,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(options.length, (index) {
        final option = options[index];
        return Column(
          children: [
            Row(
              // crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Radio Button Column
                Radio<int>(
                  value: index,
                  groupValue: selectedIndex,
                  onChanged: (value) => onChanged(value!),
                  activeColor: DefaultColors.blue_300,
                ),
                // Column for Title and Description
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      UiTextNew.h5Regular(
                        option.title,
                        color: Colors.black,
                      )
                      // Description under Radio Button
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: 12),
              child: Row(
                children: [
                  Expanded(
                    child: UiTextNew.h5Regular(
                        option.description,
                      color: DefaultColors.gray54,
                     ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 12,),

            // Divider except for the last item
            if (index != options.length - 1)
              const Divider(
                color: DefaultColors.grayE6,
                height: 1.0,
                thickness: 1,
                indent: 16.0,
                endIndent: 16.0,
              ),
          ],
        );
      }),
    );
  }
}


