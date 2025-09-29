import 'package:auto_route/auto_route.dart';
import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:flutter/material.dart';

class BeneficiaryCountryPicker extends StatefulWidget {
  final List<String> beneficiaryList;
  final String hintText;
  final String title;
  final Function(String) onTap;

  const BeneficiaryCountryPicker({
    super.key,
    required this.beneficiaryList,
    required this.hintText,
    required this.title,
    required this.onTap,
  });

  @override
  State<BeneficiaryCountryPicker> createState() => _BeneficiaryCountryPickerState();
}

class _BeneficiaryCountryPickerState extends State<BeneficiaryCountryPicker> {
  TextEditingController searchController = TextEditingController();
  List<String> displayedBeneficiaries = [];

  @override
  void initState() {
    super.initState();
    displayedBeneficiaries = widget.beneficiaryList;
    searchController.addListener(_filterBeneficiary);
  }

  void _filterBeneficiary() {
    final query = searchController.text.toLowerCase();
    setState(() {
      displayedBeneficiaries = widget.beneficiaryList.where((beneficiary) {
        return beneficiary.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  void dispose() {
    searchController.removeListener(_filterBeneficiary);
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        UiSearch(
            hintText: widget.hintText,
            controller: searchController,
          ),

        UIListView(
          elements: displayedBeneficiaries,
          padding: EdgeInsets.symmetric(vertical: 10),
          itemBuilder: (context, index) {
            final beneficiary = displayedBeneficiaries[index];
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: UiCard(
                cardColor: DefaultColors.whiteF3,
                borderColor: DefaultColors.whiteF3,
                borderRadius: BorderRadius.circular(12),
                child: ListTile(
                  title: UiTextNew.b1Regular(beneficiary,color: DefaultColors.gray2D,),
                  onTap: () {
                    widget.onTap(beneficiary);
                    context.maybePop(beneficiary);

                  },
                ),
              ),
            );
          },
        ),
        const UiSpace.vertical(10),
      ],
    );
  }
}