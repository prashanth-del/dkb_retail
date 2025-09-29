import 'package:auto_route/auto_route.dart';
import 'package:db_uicomponents/components.dart';
import 'package:flutter/material.dart';
import 'package:dkb_retail/core/constants/colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChargeTypeBottomSheet extends ConsumerStatefulWidget {
  final List<Map<String, String>> chargeTypes;
  final Function(String) onSelect;

  const ChargeTypeBottomSheet({
    Key? key,
    required this.chargeTypes,
    required this.onSelect,
  }) : super(key: key);

  @override
  ConsumerState createState() => _ChargeTypeBottomSheetState();
}

class _ChargeTypeBottomSheetState extends ConsumerState<ChargeTypeBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ...widget.chargeTypes.map(
            (charge) => UiCard(
              onTap: () {
                widget.onSelect(charge['title'] ?? '');
                context.router.maybePop();
              },
              cardColor: DefaultColors.grayF4,
              margin: const EdgeInsets.symmetric(vertical: 5),
              padding: const EdgeInsets.all(15),
              borderRadius: BorderRadius.circular(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  UiTextNew.b1Semibold(charge['title'] ?? ''),
                  const UiSpace.vertical(6),
                  UiTextNew.b14Regular(
                    charge['description'] ?? '',
                    color: DefaultColors.gray54,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
