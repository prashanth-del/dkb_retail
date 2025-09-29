import 'package:auto_route/auto_route.dart';
import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:dkb_retail/core/utils/extensions/locale_extension.dart';
import 'package:dkb_retail/features/beneficiary/presentation/controller/beneficiary_provider.dart';
import 'package:dkb_retail/features/beneficiary/presentation/widgets/page3/page3.dart';
import 'package:dkb_retail/features/common/components/auto_leading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/page1.dart';
import '../widgets/page2.dart';

@RoutePage()
class AddBeneficiaryTransferPage extends ConsumerStatefulWidget {
  const AddBeneficiaryTransferPage({super.key});

  @override
  ConsumerState<AddBeneficiaryTransferPage> createState() =>
      _AddBeneficiaryTransferState();
}

class _AddBeneficiaryTransferState
    extends ConsumerState<AddBeneficiaryTransferPage> {
  late final TransferStepperController _stepperController;

  @override
  void initState() {
    super.initState();
    _stepperController = TransferStepperController(totalSteps: 3);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isLastStep() {
      return _stepperController.currentStep == _stepperController.totalSteps;
    }

    return Scaffold(
      backgroundColor: DefaultColors.white_f3,
      appBar: UIAppBar.secondary(
        autoLeadingWidget: const AutoLeadingWidget(),
        title: ref.getLocaleString(
          "Add_New_Beneficiary",
          defaultValue: "Add New Beneficiary",
        ),
        appBarColor: DefaultColors.white,
      ),
      body: _buildStepper(),
    );
  }

  Widget _buildStepper() {
    final steps = [
      TransferStepper(
        title: ref.getLocaleString(
          "Transfer_Type",
          defaultValue: "Transfer Type",
        ),
        child: Page1(onSubmit: () => _stepperController.nextStep()),
      ),
      TransferStepper(
        title: ref.getLocaleString(
          "Beneficiary_Details",
          defaultValue: "Beneficiary Details",
        ),
        child: Page2(
          onBack: () => _stepperController.previousStep(),
          onSubmit: () => _stepperController.nextStep(),
        ),
      ),
      TransferStepper(
        title: ref.getLocaleString(
          "Bank_Details",
          defaultValue: "Bank Details",
        ),
        child: Page3(
          onBack: () => _stepperController.previousStep(),
          onSubmit: () => _stepperController.goToStep(1),
        ),
      ),
    ];

    final stepper = UiTransferStepperNew(
      steps: steps,
      controller: _stepperController,
      config: StepperConfig(
        circleRadius: steps.length < 5 ? 9 : 8,
        padding: const EdgeInsets.symmetric(horizontal: 50).copyWith(top: 10),
      ),
    );

    return ref.getLocale().toString() == "ar"
        ? stepper.toRTLDirection()
        : stepper.toLTRDirection();
  }
}
