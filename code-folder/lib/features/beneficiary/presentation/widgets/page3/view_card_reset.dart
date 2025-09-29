import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:dkb_retail/features/beneficiary/presentation/controller/beneficiary_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ViewCardReset extends ConsumerStatefulWidget {
  final bool isCountry;

  const ViewCardReset({super.key, this.isCountry = false});
  @override
  ConsumerState<ViewCardReset> createState() => _ViewCardResetState();
}

class _ViewCardResetState extends ConsumerState<ViewCardReset> {
  @override
  Widget build(BuildContext context) {
    return UiCard(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildKeyValueText(
                widget.isCountry ? "IFSC Code" : "Bank Code",
                "064-030280674",
              ),
              InkWell(
                onTap: () {
                  ref.read(cardResetProvider.notifier).state = false;
                },
                child: const UiTextNew.custom(
                  "Reset",
                  color: DefaultColors.blue60,
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const UiSpace.vertical(10),
          _buildKeyValueText("Bank Name", "Bank Of Ceylon"),
          const UiSpace.vertical(10),
          _buildKeyValueText("Branch Name", "Colombo"),
        ],
      ),
    );
  }

  Widget _buildKeyValueText(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [UiTextNew.h4Regular(title, color: DefaultColors.gray54)],
        ),
        Row(
          children: [UiTextNew.b14Medium(value, color: DefaultColors.grayD2)],
        ),
      ],
    );
  }
}
