// import 'package:db_uicomponents/db_uicomponents.dart';
// import 'package:dotted_line/dotted_line.dart';
// import 'package:flutter/material.dart';
//
// enum StepperMode {
//   initiator,
//   verifier,
//   approver,
//   completed,
// }
//
// class SubTitle{
//   final String name;
//   final bool verified;
//
//   SubTitle(this.name, this.verified);
// }
//
// abstract class StepperRole {
//   static StepperRoleState fromUserRole(StepperMode role, String iconPath,
//   final List<SubTitle> subtitles, Color bgColor, Color iconColor) {
//     switch (role) {
//       case StepperMode.initiator:
//         return StepperRoleState.initiator(
//             subtitles: subtitles,
//             iconPath: iconPath,
//             bgColor: bgColor,
//             iconColor: iconColor);
//       case StepperMode.verifier:
//         return StepperRoleState.verifier(
//             subtitles: subtitles,
//             iconPath: iconPath,
//             bgColor: bgColor,
//             iconColor: iconColor);
//       case StepperMode.approver:
//         return StepperRoleState.approver(
//             subtitles: subtitles,
//             iconPath: iconPath,
//             bgColor: bgColor,
//             iconColor: iconColor);
//       default:
//         return StepperRoleState.initiator(
//             subtitles: subtitles,
//             iconPath: iconPath,
//             bgColor: bgColor,
//             iconColor: iconColor);
//     }
//   }
// }
//
// class StepperRoleState {
//   final String title;
//   final List<SubTitle> subtitles;
//   final Color iconColor;
//   final Color bgColor;
//   final String iconPath;
//
//   const StepperRoleState({
//     required this.title,
//     required this.subtitles,
//     required this.iconColor,
//     required this.bgColor,
//     required this.iconPath,
//   });
//
//   factory StepperRoleState.initiator({
//     String title = "Initiator",
//     List<SubTitle> subtitles = const [],
//     Color bgColor = DefaultColors.greenE9,
//     Color iconColor = DefaultColors.green49,
//     required String iconPath,
//   }) {
//     return StepperRoleState(
//       title: title,
//       subtitles: subtitles,
//       bgColor: bgColor,
//       iconColor: iconColor,
//       iconPath: iconPath,
//     );
//   }
//
//   factory StepperRoleState.verifier({
//     String title = "Verifier",
//     List<SubTitle> subtitles = const [],
//     Color bgColor = DefaultColors.yellowD1,
//     Color iconColor = DefaultColors.yellow_0,
//     required String iconPath,
//   }) {
//     return StepperRoleState(
//       title: title,
//       subtitles: subtitles,
//       bgColor: bgColor,
//       iconColor: iconColor,
//       iconPath: iconPath,
//     );
//   }
//
//   factory StepperRoleState.approver({
//     String title = "Approver",
//     List<SubTitle> subtitles = const [],
//     Color bgColor = DefaultColors.yellowD1,
//     Color iconColor = DefaultColors.yellow_0,
//     required String iconPath,
//   }) {
//     return StepperRoleState(
//       title: title,
//       subtitles: subtitles,
//       bgColor: bgColor,
//       iconColor: iconColor,
//       iconPath: iconPath,
//     );
//   }
// }
//
// class UIStatusStepper extends StatelessWidget {
//   final String initiatorIconPath;
//   final String verifierIconPath;
//   final String approverIconPath;
//   final StepperMode userType;
//   final List<SubTitle> initiatorSubtitles;
//   final List<SubTitle> verifierSubtitles;
//   final List<SubTitle> approverSubtitles;
//
//   const UIStatusStepper(
//       this.userType,
//       this.initiatorIconPath,
//       this.verifierIconPath,
//       this.approverIconPath,
//       this.initiatorSubtitles,
//       this.verifierSubtitles,
//       this.approverSubtitles,
//       {super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     Color initiatorBgColor;
//     Color verifierBgColor;
//     Color approverBgColor;
//     Color initiatorIconColor;
//     Color verifierIconColor;
//     Color approverIconColor;
//
//     switch (userType) {
//       case StepperMode.initiator:
//         initiatorBgColor = DefaultColors.yellowD1;
//         verifierBgColor = DefaultColors.yellowD1;
//         approverBgColor = DefaultColors.yellowD1;
//         initiatorIconColor = DefaultColors.yellow_0;
//         verifierIconColor = DefaultColors.yellow_0;
//         approverIconColor = DefaultColors.yellow_0;
//         break;
//       case StepperMode.verifier:
//         initiatorBgColor = DefaultColors.greenE9;
//         verifierBgColor = DefaultColors.yellowD1;
//         approverBgColor = DefaultColors.yellowD1;
//         initiatorIconColor = DefaultColors.green49;
//         verifierIconColor = DefaultColors.yellow_0;
//         approverIconColor = DefaultColors.yellow_0;
//         break;
//       case StepperMode.approver:
//         initiatorBgColor = DefaultColors.greenE9;
//         verifierBgColor = DefaultColors.greenE9;
//         approverBgColor = DefaultColors.yellowD1;
//         initiatorIconColor = DefaultColors.green49;
//         verifierIconColor = DefaultColors.green49;
//         approverIconColor = DefaultColors.yellow_0;
//         break;
//       case StepperMode.completed:
//         initiatorBgColor = DefaultColors.greenE9;
//         verifierBgColor = DefaultColors.greenE9;
//         approverBgColor = DefaultColors.greenE9;
//         initiatorIconColor = DefaultColors.green49;
//         verifierIconColor = DefaultColors.green49;
//         approverIconColor = DefaultColors.green49;
//         break;
//     }
//
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         _Stepper(
//           stepperRole: StepperRoleState.initiator(
//             iconPath: initiatorIconPath,
//             bgColor: initiatorBgColor,
//             iconColor: initiatorIconColor,
//             subtitles: initiatorSubtitles
//           ),
//         ),
//         const ExpandedDottedLine(),
//         _Stepper(
//           stepperRole: StepperRoleState.verifier(
//             iconPath: verifierIconPath,
//             bgColor: verifierBgColor,
//             iconColor: verifierIconColor,
//             subtitles: verifierSubtitles
//           ),
//         ),
//         const ExpandedDottedLine(),
//         _Stepper(
//           stepperRole: StepperRoleState.approver(
//             iconPath: approverIconPath,
//             bgColor: approverBgColor,
//             iconColor: approverIconColor,
//             subtitles: approverSubtitles
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// class ExpandedDottedLine extends StatelessWidget {
//   const ExpandedDottedLine({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return const Expanded(
//       child: Padding(
//         padding: EdgeInsets.only(top: 32.0),
//         child: DottedLine(
//           dashLength: 6,
//           dashGapLength: 6,
//           dashColor: DefaultColors.white_500,
//         ),
//       ),
//     );
//   }
// }
//
// class _Stepper extends StatelessWidget {
//   final StepperRoleState stepperRole;
//
//   const _Stepper({required this.stepperRole});
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Container(
//           height: 64,
//           width: 64,
//           decoration: BoxDecoration(
//             color: stepperRole.bgColor,
//             shape: BoxShape.circle,
//           ),
//           child: UISvgIcon(
//             assetPath: stepperRole.iconPath,
//             color: stepperRole.iconColor,
//             width: 16,
//             height: 16,
//             fit: BoxFit.scaleDown,
//           ),
//         ),
//         UiTextNew.b2Medium(
//           stepperRole.title,
//           color: DefaultColors.blue_900,
//         ),
//         ...stepperRole.subtitles.map((entry) => Row(
//           children: [
//             Visibility(
//               visible: true,
//               child: Container(
//                 height: 8,
//                 width: 8,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: entry.verified ? DefaultColors.green49 : DefaultColors.yellow_0,
//                 ),
//               ),
//             ),
//             const UiSpace.horizontal(2.0),
//             UiTextNew.b3Light(
//               entry.name,
//               color: DefaultColors.white_750,
//             ),
//           ],
//         )),
//       ],
//     );
//   }
// }