import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:flutter/material.dart';

class UiExpandableCard extends StatefulWidget {
  final Map<String, dynamic> item;
  final Widget visibleContent;
  final Widget hiddenContent;
  final Color backgroundColor;

  const UiExpandableCard({
    super.key,
    required this.item,
    required this.visibleContent,
    required this.hiddenContent,
    this.backgroundColor = DefaultColors.white,
  });

  @override
  State<UiExpandableCard> createState() => _UiExpandableCardState();
}

class _UiExpandableCardState extends State<UiExpandableCard> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return UiCard(
      cardColor: widget.backgroundColor,
      padding: const EdgeInsets.all(13),
      margin: const EdgeInsets.only(top: 10),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: widget.visibleContent),
              Container(
                  margin: const EdgeInsets.only(right: 2, top: 10),
                  child: IconButton(
                      onPressed: () {
                        setState(() {
                          isExpanded = !isExpanded;
                        });
                      },
                      icon: isExpanded == false
                          ? const Icon(
                              Icons.keyboard_arrow_down,
                              color: DefaultColors.blue9D,
                            )
                          : const Icon(
                              Icons.keyboard_arrow_up,
                              color: DefaultColors.blue9D,
                            ))),
            ],
          ),
          const UiSpace.vertical(10),
          AnimatedCrossFade(
            duration: const Duration(milliseconds: 300),
            firstChild: const SizedBox.shrink(),
            secondChild: SizedBox(
              child: Row(
                children: [
                  Expanded(child: widget.hiddenContent),
                ],
              ),
            ),
            crossFadeState: isExpanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
          ),
        ],
      ),
    );
  }
}
