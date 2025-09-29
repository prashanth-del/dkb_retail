import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:db_uicomponents/src/components/transfer_stepper/ui_transfer_stepper.dart';
import 'package:flutter/material.dart';

class TransferStepperController extends ChangeNotifier {
  int _currentStep = 1;
  final int totalSteps;

  TransferStepperController({required this.totalSteps});

  int get currentStep => _currentStep;

  void goToStep(int step) {
    if (step >= 1 && step <= totalSteps) {
      _currentStep = step;
      notifyListeners();
    }
  }

  void nextStep() {
    if (_currentStep < totalSteps) {
      _currentStep++;
      notifyListeners();
    }
  }

  void previousStep() {
    if (_currentStep > 1) {
      _currentStep--;
      notifyListeners();
    }
  }

  TransferStepStatusNew getStepStatus(int stepIndex) {
    if (stepIndex < _currentStep) return TransferStepStatusNew.completed;
    if (stepIndex == _currentStep) return TransferStepStatusNew.started;
    return TransferStepStatusNew.pending;
  }
}
