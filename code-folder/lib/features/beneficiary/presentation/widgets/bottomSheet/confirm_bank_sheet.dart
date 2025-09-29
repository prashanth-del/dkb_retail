import 'package:auto_route/auto_route.dart';
import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:dkb_retail/features/beneficiary/presentation/controller/beneficiary_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ConfirmBankSheet extends ConsumerStatefulWidget {
  final String bankBranchCode;
  final String bankName;
  final String branchLocation;
  final String bankTitle;

  const ConfirmBankSheet({
    super.key,
    required this.bankBranchCode,
    required this.bankName,
    required this.branchLocation,
    required this.bankTitle,
  });

  @override
  ConsumerState<ConfirmBankSheet> createState() => _ConfirmBankSheetState();
}

class _ConfirmBankSheetState extends ConsumerState<ConfirmBankSheet> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        UiCard(
          onTap: () {
            ref.read(cardResetProvider.notifier).state = true;
            context.maybePop();
          },
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          cardColor: DefaultColors.whiteF3,
          borderColor: DefaultColors.whiteF3,
          borderRadius: BorderRadius.circular(12),
          child: Column(
            children: [
              Row(
                children: [
                  UiTextNew.h4Regular(
                    widget.bankTitle,
                    color: DefaultColors.gray54,
                  ),
                  const UiSpace.horizontal(5),
                  const UiTextNew.b14Medium(
                    "064-030280674",
                    color: DefaultColors.blueprimary,
                  ),
                ],
              ),
              const Row(
                children: [
                  UiTextNew.b1Medium(
                    "Bank Asia Limited",
                    color: DefaultColors.gray2D,
                  ),
                ],
              ),
              const Row(
                children: [
                  UiTextNew.b1Medium("India", color: DefaultColors.gray8A),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
