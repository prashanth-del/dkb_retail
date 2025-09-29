import 'package:db_uicomponents/components.dart';
import 'package:dkb_retail/core/constants/colors.dart';
import 'package:dkb_retail/features/beneficiary/presentation/widgets/bottomSheet/view_beneficiary_details.dart';
import 'package:dkb_retail/features/beneficiary/presentation/widgets/bottomSheet/view_bottom_sheet.dart';
import 'package:flutter/material.dart';

class BeneficiaryUserCard extends StatelessWidget {
  final List<UserModel> users;
  final String? statusType;

  const BeneficiaryUserCard({super.key, required this.users, this.statusType});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: users.map((user) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 10), // Space between cards
          child: UiCard(
            onTap: () {
              viewBottomSheet(
                context: context,
                title: "Beneficiary Details",
                heightPercentage: 0.5,
                child: ViewBeneficiaryDetails(
                  statusType: statusType ?? "Approved",
                ),
              );
            },
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
            borderRadius: BorderRadius.circular(12),
            child: Row(
              children: [
                Container(
                  width: 35,
                  height: 35,
                  decoration: const BoxDecoration(
                    color: DefaultColors.blue02,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: UiTextNew.b14Medium(
                      user.initials,
                      color: DefaultColors.black2,
                    ),
                  ),
                ),
                const UiSpace.horizontal(15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    UiTextNew.b14Medium(user.name, color: DefaultColors.gray2D),
                    UiTextNew.h5Regular(
                      user.accountDetails,
                      color: DefaultColors.gray2D,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

class UserModel {
  final String initials;
  final String name;
  final String accountDetails;

  UserModel({
    required this.initials,
    required this.name,
    required this.accountDetails,
  });
}
