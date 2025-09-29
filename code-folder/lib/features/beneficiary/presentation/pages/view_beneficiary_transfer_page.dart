import 'package:auto_route/auto_route.dart';
import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:dkb_retail/core/constants/app_strings/default_string.dart';
import 'package:dkb_retail/core/utils/extensions/locale_extension.dart';
import 'package:dkb_retail/features/beneficiary/presentation/pages/beneficiary_tabs.dart';
import 'package:dkb_retail/features/common/components/auto_leading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class ViewBeneficiaryTransferPage extends ConsumerStatefulWidget {
  const ViewBeneficiaryTransferPage({super.key});

  @override
  ConsumerState<ViewBeneficiaryTransferPage> createState() =>
      _ViewBeneficiaryTransferPageState();
}

class _ViewBeneficiaryTransferPageState
    extends ConsumerState<ViewBeneficiaryTransferPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DefaultColors.white_f3,
      appBar: const UIAppBar.secondary(
        autoLeadingWidget: AutoLeadingWidget(),
        title: "Beneficiaries",
        appBarColor: DefaultColors.white,
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: UiSearch(
              borderColorOfSearch: DefaultColors.grayE6,
              hintText: DefaultString.instance.searchBen,
              // controller: searchController,
            ),
          ),
          const Expanded(child: BeneficiaryTabs()),
        ],
      ),
      // body: Column(
      //     children: [],
      // ),
    );
  }
}
