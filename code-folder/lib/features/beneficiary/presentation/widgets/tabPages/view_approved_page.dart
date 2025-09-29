import 'package:db_uicomponents/components.dart';
import 'package:dkb_retail/core/constants/colors.dart';
import 'package:dkb_retail/features/beneficiary/presentation/widgets/tabPages/beneficiary_user_card.dart';
import 'package:flutter/material.dart';

class ViewApprovedPage extends StatefulWidget {
  const ViewApprovedPage({super.key});

  @override
  State<ViewApprovedPage> createState() => _ViewApprovedPageState();
}

class _ViewApprovedPageState extends State<ViewApprovedPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          BeneficiaryUserCard(
            users: [
              UserModel(
                initials: "K",
                name: "Krishna Ketan Nagu",
                accountDetails: "HDFC Bank   000056789043",
              ),
              UserModel(
                initials: "F",
                name: "Faisal Mubarak Shaul Hameed",
                accountDetails: "SBI Bank   000987654321",
              ),
              UserModel(
                initials: "R",
                name: "Ramesh Muthiah",
                accountDetails: "SBI Bank   000987654321",
              ),
              UserModel(
                initials: "P",
                name: "Philip Pappachen Thomas",
                accountDetails: "SBI Bank   000987654321",
              ),
              UserModel(
                initials: "T",
                name: "Tarun Behal ",
                accountDetails: "SBI Bank   000987654321",
              ),
              UserModel(
                initials: "A",
                name: "Abdul Sayed Pothu Kandiyil",
                accountDetails: "SBI Bank   000987654321",
              ),
            ],
          ),
        ],
      ),
    );
  }
}
