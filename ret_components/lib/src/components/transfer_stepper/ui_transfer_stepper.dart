import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:db_uicomponents/src/components/transfer_stepper/transfer_stepper_controller.dart';
import 'package:flutter/material.dart';

enum TransferStepStatusNew {
  pending,
  started,
  completed,
}

class TransferStepper {
  final String title;
  final Widget? child;
  final TransferStepStatusNew? status;

  const TransferStepper({
    required this.title,
    this.child,
    this.status = TransferStepStatusNew.pending,
  });
}

class UiTransferStepperNew extends StatelessWidget {
  final List<TransferStepper> steps;
  final TransferStepperController controller;
  final StepperConfig config;

  const UiTransferStepperNew({
    super.key,
    required this.steps,
    required this.controller,
    this.config = const StepperConfig(),
  });

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) {
        return Column(
          children: [
            StepperLayout(
              steps: steps,
              currentStep: controller.currentStep,
              config: config,
            ),
            if (steps[controller.currentStep - 1].child != null) ...[
              Expanded(
                child: SingleChildScrollView(
                  child: steps[controller.currentStep - 1].child!,
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}

class StepperConfig {
  final double circleRadius;
  final EdgeInsets padding;
  final Map<TransferStepStatusNew, Color> statusColors;

  const StepperConfig({
    this.circleRadius = 9,
    this.padding = const EdgeInsets.symmetric(horizontal: 10),
    this.statusColors = const {
      TransferStepStatusNew.pending: DefaultColors.grayB3,
      TransferStepStatusNew.started: DefaultColors.blue60,
      TransferStepStatusNew.completed: DefaultColors.greenStatus,
    },
  });
}

class StepperLayout extends StatelessWidget {
  final List<TransferStepper> steps;
  final int currentStep;
  final StepperConfig config;

  const StepperLayout({
    super.key,
    required this.steps,
    required this.currentStep,
    required this.config,
  });

  @override
  Widget build(BuildContext context) {
    double fontSize = 12;
    if(steps.length > 4){
      fontSize = 9;
    }

    return Padding(
      padding: config.padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: steps.asMap().entries.map((entry) {
              int index = entry.key;
              return _buildStep(context, index: index + 1);
            }).toList(),
          ),
          const SizedBox(height: 10),
          IntrinsicHeight(
            child: Row(
              children: steps.asMap().entries.map((entry) {
                int index = entry.key;
                return Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        if (index > 0) const SizedBox(width: double.infinity),
                        _buildText(entry.value.title, index + 1, fontSize: fontSize),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStep(BuildContext context, {required int index}) {
    TransferStepStatusNew status = _getStepStatus(index);
    Color color = config.statusColors[status] ??
        config.statusColors[TransferStepStatusNew.pending]!;

    Color prevColor = color;

    if (index > 1) {
      TransferStepStatusNew prevStatus = _getStepStatus(index - 1);
      // prevColor = config.statusColors[prevStatus] ??
      //     config.statusColors[TransferStepStatusNew.pending]!;
      if (prevStatus == TransferStepStatusNew.completed) {
        prevColor = DefaultColors.greenStatus;
      }
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (index > 1) _buildDivider(context, color: prevColor),
        if (index > 1) const SizedBox(width: 5),
        _buildCircle(color: color, status: status),
        if (index < steps.length) const SizedBox(width: 5),
        if (index < steps.length) _buildDivider(context, color: color),
      ],
    );
  }

  TransferStepStatusNew _getStepStatus(int index) {
    if (index == steps.length && index == currentStep) {
      // if current is last always completed
      return TransferStepStatusNew.completed;
    }
    if (index < currentStep) return TransferStepStatusNew.completed;
    if (index == currentStep) return TransferStepStatusNew.started;

    return TransferStepStatusNew.pending;
  }

  Widget _buildText(String title, int index, {double fontSize = 12,}) {
    TransferStepStatusNew status = _getStepStatus(index);
    Color textColor;

    if (status == TransferStepStatusNew.completed) {
      textColor = Colors.green; // Set to green for completed status
    } else {
      textColor =
      index == currentStep ? DefaultColors.blue9D : DefaultColors.white_700;
    }
    return UiTextNew.custom(
      title,
      textAlign: TextAlign.center,
      fontSize: fontSize,
      fontWeight: FontWeight.normal,
      color: textColor,
      //color: index == currentStep ? DefaultColors.blue9D : DefaultColors.white_700,
    );
  }

  Widget _buildCircle({
    required Color color,
    required TransferStepStatusNew status,
  }) {
    double circleRadius = status == TransferStepStatusNew.started
        ? config.circleRadius - 3
        : config.circleRadius;

    Widget circleAvatar = CircleAvatar(
      radius: circleRadius,
      backgroundColor: color,
      child: status == TransferStepStatusNew.completed
          ? const Icon(Icons.check, color: Colors.white, size: 10)
          : const SizedBox.shrink(),
    );

    return status == TransferStepStatusNew.started
        ? Container(
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: color,
          width: 2,
        ),
      ),
      child: circleAvatar,
    )
        : circleAvatar;
  }

  Widget _buildDivider(BuildContext context, {required Color color}) {
    double dividerMWidth =
    steps.length < 5 ? _width(context, 8.5) : _width(context, 6.5);

    return Container(
      margin: const EdgeInsets.only(top: 5),
      width: _width(context, 100) < 600 ? dividerMWidth : _width(context, 12),
      child: Divider(
        thickness: 2,
        color: color,
        height: 0,
      ),
    );
  }

  double _width(BuildContext context, double percent) =>
      ((percent / 100) * MediaQuery.of(context).size.width);
}
