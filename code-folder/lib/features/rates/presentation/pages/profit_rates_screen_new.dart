// import 'package:auto_route/auto_route.dart';
// import 'package:db_uicomponents/components.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:intl/intl.dart';
// import '../../../../core/constants/app_strings/default_string.dart';
// import '../../../../core/constants/colors.dart';
// import '../../../../core/utils/ui_components/auto_leading_widget.dart';
// import '../controller/state/profit_rates_notifier.dart';
// import '../../domain/entities/profit_rates.dart';
//
// @RoutePage(name: "ProfitRatesPageRoute")
// class ProfitRatesPage extends ConsumerStatefulWidget {
//   const ProfitRatesPage({super.key});
//
//   @override
//   ConsumerState<ProfitRatesPage> createState() => _ProfitRatesPageState();
// }
//
// class _ProfitRatesPageState extends ConsumerState<ProfitRatesPage> {
//   int? expandedIndex;
//   int selectedTabIndex = 0;
//
//   // Tabs and mapping aligned with new productType codes
//   final tabs = [
//     {"label": "Time Deposit", "code": "NTD"},
//     {"label": "Savings", "code": "SAV"},
//     {"label": "Fassel", "code": "SSV"},
//     {"label": "Exceptional Saving Plus", "code": "MSP"},
//     {"label": "Profit in Advance Deposit", "code": "PIA"},
//     {"label": "Exceptional Savings", "code": "MSS"},
//   ];
//
//   @override
//   void initState() {
//     super.initState();
//     Future.microtask(
//           () => ref.read(profitRatesNotifierProvider.notifier).fetchProfitRates(),
//     );
//   }
//
//   String formatDate(String dateStr) {
//     try {
//       final date = DateTime.parse(dateStr);
//       return DateFormat('dd/MM/yyyy').format(date);
//     } catch (e) {
//       return dateStr;
//     }
//   }
//
//   String _getTabLabel(String productType) {
//     final tab = tabs.firstWhere(
//           (t) => t["code"] == productType,
//       orElse: () => {"label": productType},
//     );
//     return tab["label"]!;
//   }
//
//   Widget _buildRateCard(ProfitRates rate, int index) {
//     final isExpanded = expandedIndex == index;
//
//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           expandedIndex = isExpanded ? null : index;
//         });
//       },
//       child: Container(
//         margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(20),
//           gradient: LinearGradient(
//             colors: [Colors.grey.shade100, Colors.grey.shade200],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.08),
//               blurRadius: 15,
//               offset: const Offset(0, 6),
//             ),
//           ],
//         ),
//         child: Container(
//           padding: const EdgeInsets.all(20),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(20),
//             color: Colors.white,
//           ),
//           child: Column(
//             children: [
//               Row(
//                 children: [
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           _getTabLabel(rate.productType),
//                           style: const TextStyle(
//                             fontSize: 17,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.black87,
//                           ),
//                         ),
//                         const SizedBox(height: 6),
//                         Row(
//                           children: [
//                             Container(
//                               padding: const EdgeInsets.symmetric(
//                                 horizontal: 12,
//                                 vertical: 5,
//                               ),
//                               decoration: BoxDecoration(
//                                 color: Colors.blue.shade50,
//                                 borderRadius: BorderRadius.circular(14),
//                               ),
//                               child: Text(
//                                 rate.productSubtype ?? "-",
//                                 style: const TextStyle(
//                                   fontSize: 13,
//                                   fontWeight: FontWeight.w600,
//                                   color: Colors.blueGrey,
//                                 ),
//                               ),
//                             ),
//                             SizedBox(width: 5),
//                             Container(
//                               padding: const EdgeInsets.symmetric(
//                                 horizontal: 12,
//                                 vertical: 5,
//                               ),
//                               decoration: BoxDecoration(
//                                 color: Colors.blue.shade50,
//                                 borderRadius: BorderRadius.circular(14),
//                               ),
//                               child: Text(
//                                 'QAR',
//                                 style: const TextStyle(
//                                   fontSize: 13,
//                                   fontWeight: FontWeight.w600,
//                                   color: Colors.blueGrey,
//                                 ),
//                               ),
//                             ),
//                             SizedBox(width: 5),
//                             Container(
//                               padding: const EdgeInsets.symmetric(
//                                 horizontal: 12,
//                                 vertical: 5,
//                               ),
//                               decoration: BoxDecoration(
//                                 color: Colors.blue.shade50,
//                                 borderRadius: BorderRadius.circular(14),
//                               ),
//                               child: Text(
//                                 'RET',
//                                 style: const TextStyle(
//                                   fontSize: 13,
//                                   fontWeight: FontWeight.w600,
//                                   color: Colors.blueGrey,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     children: [
//                       Text(
//                         rate.rate.toString(),
//                         style: const TextStyle(
//                           fontSize: 21,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.indigo,
//                         ),
//                       ),
//                       const SizedBox(height: 4),
//                       Row(
//                         children: [
//                           Text(
//                             formatDate(rate.rateCreationDate) ?? "-",
//                             style: TextStyle(
//                               fontSize: 12,
//                               color: Colors.grey.shade600,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                   const SizedBox(width: 8),
//                   AnimatedRotation(
//                     turns: isExpanded ? 0.5 : 0.0,
//                     duration: const Duration(milliseconds: 300),
//                     child: Icon(
//                       Icons.keyboard_arrow_down,
//                       color: Colors.grey.shade600,
//                       size: 26,
//                     ),
//                   ),
//                 ],
//               ),
//               AnimatedSize(
//                 duration: const Duration(milliseconds: 400),
//                 curve: Curves.easeInOut,
//                 child: isExpanded
//                     ? Padding(
//                   padding: const EdgeInsets.only(top: 16),
//                   child: Column(
//                     children: [
//                       const Divider(thickness: 0.5, color: Colors.grey),
//                       const SizedBox(height: 12),
//                       Wrap(
//                         spacing: 14,
//                         runSpacing: 14,
//                         children: [
//                           _detailChip("Currency", "QAR"),
//                           _detailChip(
//                             "Last Month Date",
//                             formatDate(rate.lastMonthDate) ?? "-",
//                           ),
//                           _detailChip(
//                             "Creation Date",
//                             formatDate(rate.rateCreationDate) ?? "-",
//                           ),
//                           _detailChip(
//                             "Tenure",
//                             rate.productSubtype ?? "-",
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 )
//                     : const SizedBox.shrink(),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _detailChip(String label, String value) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
//       decoration: BoxDecoration(
//         color: Colors.grey.shade50,
//         borderRadius: BorderRadius.circular(14),
//         border: Border.all(color: Colors.grey.shade200, width: 1),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.02),
//             blurRadius: 4,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       width: 160,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Text(
//                 label,
//                 style: TextStyle(
//                   fontSize: 12,
//                   fontWeight: FontWeight.w500,
//                   color: Colors.grey.shade700,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 6),
//           Text(
//             value,
//             style: const TextStyle(
//               fontSize: 14,
//               fontWeight: FontWeight.bold,
//               color: Colors.black87,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final w = MediaQuery.of(context).size.width;
//     final state = ref.watch(profitRatesNotifierProvider);
//
//     return Scaffold(
//       appBar: UIAppBar.secondary(
//         appBarColor: DefaultColors.white,
//         title: '',
//         autoLeadingWidget: LeadingWidget(
//           title: DefaultString.instance.profitRatesTitle,
//         ),
//       ),
//       body: state.when(
//         initial: () => const SizedBox.shrink(),
//         loading: () => const Center(child: CircularProgressIndicator()),
//         failure: (message) => Center(child: Text(message)),
//         success: (rates) {
//           // Group rates by tab
//           final grouped = <String, List<ProfitRates>>{};
//           for (var tab in tabs) {
//             grouped[tab["label"]!] = rates
//                 .where((r) => r.productType == tab["code"])
//                 .toList();
//           }
//
//           return Column(
//             children: [
//               // Tabs
//               SingleChildScrollView(
//                 scrollDirection: Axis.horizontal,
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 16,
//                   vertical: 12,
//                 ),
//                 child: Row(
//                   children: tabs.asMap().entries.map((entry) {
//                     int index = entry.key;
//                     final tab = entry.value;
//                     final isSelected = selectedTabIndex == index;
//                     final tabRates = grouped[tab["label"]] ?? [];
//
//                     return Padding(
//                       padding: EdgeInsets.only(right: w * 0.025),
//                       child: GestureDetector(
//                         onTap: () => setState(() => selectedTabIndex = index),
//                         child: AnimatedContainer(
//                           duration: const Duration(milliseconds: 300),
//                           padding: EdgeInsets.symmetric(
//                             horizontal: w * 0.045,
//                             vertical: 10,
//                           ),
//                           decoration: BoxDecoration(
//                             // gradient: isSelected
//                             //     ? LinearGradient(colors: [Colors.blue.shade400, Colors.blue.shade600])
//                             //     : null,
//                             color: isSelected
//                                 ? DefaultColors.blue98
//                                 : Colors.grey.shade100,
//                             border: Border.all(
//                               color: isSelected
//                                   ? Colors.transparent
//                                   : Colors.grey.shade300,
//                               width: 1,
//                             ),
//                             borderRadius: BorderRadius.circular(25),
//                             boxShadow: isSelected
//                                 ? [
//                               BoxShadow(
//                                 color: Colors.blue.shade100,
//                                 blurRadius: 6,
//                                 offset: const Offset(0, 3),
//                               ),
//                             ]
//                                 : [],
//                           ),
//                           child: Row(
//                             children: [
//                               Text(
//                                 tab["label"]!,
//                                 style: TextStyle(
//                                   color: isSelected
//                                       ? Colors.white
//                                       : Colors.black,
//                                   fontWeight: FontWeight.w600,
//                                   fontSize: w * 0.035,
//                                 ),
//                               ),
//                               const SizedBox(width: 6),
//                               Text(
//                                 "${tabRates.length}",
//                                 style: TextStyle(
//                                   fontSize: w * 0.03,
//                                   fontWeight: FontWeight.bold,
//                                   color: isSelected
//                                       ? Colors.white
//                                       : Colors.black,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     );
//                   }).toList(),
//                 ),
//               ),
//
//               // Rate Cards
//               Expanded(
//                 child: grouped[tabs[selectedTabIndex]["label"]]!.isEmpty
//                     ? Center(
//                   child: Text(DefaultString.instance.noDataAvailable),
//                 )
//                     : ListView.builder(
//                   itemCount:
//                   grouped[tabs[selectedTabIndex]["label"]]!.length,
//                   itemBuilder: (context, i) {
//                     final rate =
//                     grouped[tabs[selectedTabIndex]["label"]]![i];
//                     return _buildRateCard(rate, i);
//                   },
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }
