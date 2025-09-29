import 'package:auto_route/auto_route.dart';
import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:flutter/material.dart';
import 'package:dkb_retail/core/constants/app_strings/default_string.dart';

import '../../../../core/router/app_router.dart';
import '../../data/model/beneficiary_model.dart';

class BeneficiaryPickerSheet extends StatefulWidget {
  final List<BeneficiaryModel> beneficiaryList;
  final String hintText;
  final String title;
  final bool isFlag;
  final bool displayBank;
  final bool displayAccountNum;
  final bool displayIfsc;
  final bool showAdd;

  const BeneficiaryPickerSheet({
    super.key,
    required this.beneficiaryList,
    required this.hintText,
    required this.title,
    this.isFlag = true,
    this.displayBank = false,
    this.displayAccountNum = true,
    this.displayIfsc = false,
    this.showAdd = true,
  });

  @override
  State<BeneficiaryPickerSheet> createState() => _BeneficiaryPickerSheetState();
}

class _BeneficiaryPickerSheetState extends State<BeneficiaryPickerSheet> {
  TextEditingController searchController = TextEditingController();
  List<BeneficiaryModel> displayedBeneficiaries = [];

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
        final beneficiaryName = beneficiary.name.toLowerCase();
        final accNum = beneficiary.accountNumber.toLowerCase() ?? '';
        return beneficiaryName.contains(query) || accNum.contains(query);
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
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Column(
        children: [
          ListTile(
            leading: UIIconContainer(
              icon: Icons.arrow_back_ios,
              color: DefaultColors.transparent,
              iconColor: DefaultColors.black,
              iconSize: 18,
              onTap: () {
                context.router.maybePop();
              },
            ),
            minLeadingWidth: 0,
            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
            title: UiTextNew.b1Semibold(widget.title),
            trailing: UIIconContainer(
              icon: Icons.close,
              color: DefaultColors.transparent,
              iconColor: DefaultColors.black,
              iconSize: 18,
              onTap: () {
                context.router.maybePop();
              },
            ),
          ),
          const Divider(color: DefaultColors.gray1F),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: UiSearch(
              hintText: widget.hintText,
              controller: searchController,
            ),
          ),
          const UiSpace.vertical(10),
          if (widget.showAdd)
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 20),
              leading: const CircleAvatar(
                radius: 20,
                backgroundColor: DefaultColors.blue88,
                child: Icon(Icons.add, color: DefaultColors.white),
              ),
              title: UiTextNew.h4Medium(
                DefaultString.instance.addNew,
                color: DefaultColors.blue88,
              ),
              onTap: () {
                context.router.push(const AddBeneficiaryTransferRoute());
              },
            ),
          if (widget.showAdd)
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Divider(color: DefaultColors.grayE5),
            ),
          Expanded(
            child: ListView.builder(
              itemCount: displayedBeneficiaries.length,
              itemBuilder: (context, index) {
                final beneficiary = displayedBeneficiaries[index];
                return ListTile(
                  leading: widget.isFlag
                      ? CircleAvatar(
                          radius: 24,
                          child: Center(
                            child: Image.asset(
                              "assets/images/flags/${beneficiary.flag.flag}",
                            ),
                          ),
                        )
                      : CircleAvatar(
                          radius: 24,
                          backgroundColor: DefaultColors.blue_02,
                          child: Center(
                            child: UiTextNew.h4Medium(
                              beneficiary.name[0],
                              color: DefaultColors.blue88,
                            ),
                          ),
                        ),
                  title: UiTextNew.h4Medium(beneficiary.name),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (widget.displayBank)
                        UiTextNew.h5Regular(beneficiary.bankName),
                      if (widget.displayIfsc)
                        UiTextNew.h5Regular(beneficiary.ifsc),
                      if (widget.displayAccountNum)
                        UiTextNew.h5Regular(beneficiary.accountNumber),
                    ],
                  ),
                  onTap: () {
                    context.router.maybePop(beneficiary);
                  },
                );
              },
            ),
          ),
          const UiSpace.vertical(10),
        ],
      ),
    );
  }
}
