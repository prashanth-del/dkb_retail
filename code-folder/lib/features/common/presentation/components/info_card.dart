import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class InfoCard extends StatelessWidget {
  final String title;
  final List<String> descriptions;

  const InfoCard({super.key, required this.title, required this.descriptions});

  @override
  Widget build(BuildContext context) {
    return UiCard(
      padding: const EdgeInsets.all(10),
      cardColor: DefaultColors.yellowBG,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if(title.isNotEmpty)
          UiTextNew.b2Semibold(
              title
          ),
          if(title.isNotEmpty)
          const UiSpace.vertical(7),
          ...descriptions.map(
                (description) => Container(
              margin: const EdgeInsets.only(left: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '\u2022',
                    style: TextStyle(fontSize: 11),
                  ),
                  Flexible(
                    child: UiTextNew.b2Regular(
                      description,


                    ),
                  ),
                ].space(8),
              ).vertical(4),
            ),
          ),
        ],
      ),
    ).vertical(15);
  }
}

extension on List<Widget> {
  List<Widget> space(double space) {
    int length = this.length;

    for (int i = 0; i < length; i++) {
      if (i % 2 != 0) {
        insert(i, Gap(space));
        length++;
      }
    }

    return this;
  }
}