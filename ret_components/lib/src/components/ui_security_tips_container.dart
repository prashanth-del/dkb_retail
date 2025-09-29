import 'package:flutter/material.dart';

import '../styles/theme/colorscheme/colors/default_colors.dart';

const List<String> securityTipsForPassword = [
  "Use a password with unusual capitalization",
  "Use a password with alphanumeric character e.g. number",
  "Use concatenation of words or part of words",
  "Keep changing your password frequently",
  "Password should not contain any special characters",
];

class UiSecurityTipsContainer extends StatelessWidget {
  const UiSecurityTipsContainer(
      {super.key, this.tips = securityTipsForPassword});

  final List<String> tips;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: DefaultColors.yellowBG,
          padding: const EdgeInsets.all(8.0),
          child: Table(
            columnWidths: const {
              0: FractionColumnWidth(0.1),
              1: FlexColumnWidth(),
            },
            children: [
              const TableRow(
                children: [
                  Icon(Icons.info_outline),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      "Security Tips",
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              ),
              ...tips.map(
                (e) => TableRow(
                    children: [const Center(child: Text('\u2022')), Text(e)]),
              )
            ],
          ),
        ),
      ],
    );
  }
}
