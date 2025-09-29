import 'package:auto_route/auto_route.dart';
import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:dkb_retail/core/constants/asset_path/asset_path.dart';
import 'package:dkb_retail/features/common/components/auto_leading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/ui_components/components/consts/filter_options.dart';
import '../../../../core/utils/ui_components/components/src/ui_error.dart';
import '../../data/models/transaction_analysis_dto.dart';
import '../../domain/entity/request/transaction_filter_req.dart';
import '../controller/notifier/get_transaction_analysis_notifier.dart';
import '../widgets/transaction_analysis/trasaction_table/channel_breakdown_view.dart';
import '../widgets/transaction_analysis/trasaction_table/trasaction_table_loading_placeholder.dart';

@RoutePage()
class TransactionDataTablePage extends ConsumerStatefulWidget {
  const TransactionDataTablePage({super.key});

  @override
  _TransactionDataTableState createState() => _TransactionDataTableState();
}

class _TransactionDataTableState
    extends ConsumerState<TransactionDataTablePage> {
  String? selectedServiceType;
  bool _isAscending = true;
  int _sortColumnIndex = 1;

  @override
  void initState() {
    super.initState();
    // _setLandscapeOrientation();
    _loadData();
  }

  @override
  void dispose() {
    _resetOrientation();
    super.dispose();
  }

  void _setLandscapeOrientation() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    });
  }

  void _resetOrientation() {
    SystemChrome.setPreferredOrientations(DeviceOrientation.values);
  }

  void _loadData() {
    Future(
      () => ref
          .read(transactionTableAnalysisNotifierProvider.notifier)
          .fetch(
            const TransactionFilterReq(
              type: "ALL",
              channels: FilterOptions.fullChannelIds,
            ),
          ),
    );
  }

  List<TransactionService> _getSortedServices(
    List<TransactionService> services,
  ) {
    List<TransactionService> sortedServices = List.from(services);
    sortedServices.sort((a, b) {
      switch (_sortColumnIndex) {
        case 1:
          return _compare(
            a.successCount + a.failureCount,
            b.successCount + b.failureCount,
          );
        case 2:
          return _compare(a.successCount, b.successCount);
        case 3:
          return _compare(a.failureCount, b.failureCount);
        default:
          return 0;
      }
    });
    return sortedServices;
  }

  int _compare(num a, num b) {
    return _isAscending ? a.compareTo(b) : b.compareTo(a);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD9E5F0),
      appBar: _buildAppBar(context),
      body: ref
          .watch(transactionTableAnalysisNotifierProvider)
          .when(
            data: (data) => _buildDataTable(context, data.services ?? []),
            error: (error, _) => UiServerError(
              lottieAssetPath: AssetPath.lottie.empty,
              errorMessage: error.toString(),
            ),
            loading: () => const TrasactionTableLoadingPlaceholder(),
          ),
    );
  }

  _buildAppBar(BuildContext context) {
    return const UIAppBar.secondary(
      autoLeadingWidget: AutoLeadingWidget(),
      title: 'Transaction Analysis',
    );
  }

  Widget _buildDataTable(
    BuildContext context,
    List<TransactionService> services,
  ) {
    List<TransactionService> sortedServices = _getSortedServices(services);
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          sortAscending: _isAscending,
          sortColumnIndex: _sortColumnIndex,
          headingRowColor: WidgetStateColor.resolveWith((_) => Colors.black12),
          columnSpacing: 8.0,
          // border: TableBorder.all(color: Colors.black26),
          dividerThickness: 0.5,
          columns: _buildDataColumns(),
          rows: _buildDataRows(context, sortedServices),
        ),
      ),
    );
  }

  List<DataColumn> _buildDataColumns() {
    return [
      DataColumn(label: _buildHeader('Service Type')),
      DataColumn(
        label: _buildHeader('Total'),
        onSort: (columnIndex, ascending) => _onSort(columnIndex, ascending),
      ),
      DataColumn(
        label: _buildHeader('Success'),
        onSort: (columnIndex, ascending) => _onSort(columnIndex, ascending),
      ),
      DataColumn(
        label: _buildHeader('Failure'),
        onSort: (columnIndex, ascending) => _onSort(columnIndex, ascending),
      ),
      // DataColumn(label: Icon(Icons.more_vert,
      //     color: const Color(0xFF000000).withOpacity(0.7))),
    ];
  }

  Text _buildHeader(String title) {
    return Text(title, style: const TextStyle(fontWeight: FontWeight.bold));
  }

  void _onSort(int columnIndex, bool ascending) {
    setState(() {
      _sortColumnIndex = columnIndex;
      _isAscending = ascending;
    });
  }

  List<DataRow> _buildDataRows(
    BuildContext context,
    List<TransactionService> services,
  ) {
    return services.map((service) {
      final totalTransaction = service.successCount + service.failureCount;
      return DataRow(
        cells: [
          DataCell(
            UiTextNew.b2Regular(service.serviceType.toString()),
            onTap: () =>
                _showCustomWidthDialog(context, service.channelBreakdown),
          ),
          DataCell(
            UiTextNew.b2Regular(totalTransaction.toString()),
            onTap: () =>
                _showCustomWidthDialog(context, service.channelBreakdown),
          ),
          DataCell(
            UiTextNew.b2Semibold(
              service.successCount.toString(),
              color: DefaultColors.green49,
            ),
            onTap: () =>
                _showCustomWidthDialog(context, service.channelBreakdown),
          ),
          DataCell(
            UiTextNew.b2Semibold(
              service.failureCount.toString(),
              color: DefaultColors.red_09,
            ),
            onTap: () =>
                _showCustomWidthDialog(context, service.channelBreakdown),
          ),
          // DataCell(_buildReasonCell(context, service.channelBreakdown)),
        ],
      );
    }).toList();
  }

  Widget _buildReasonCell(
    BuildContext context,
    List<TransactionChannelBreakdown> breakdown,
  ) {
    return GestureDetector(
      onTap: () => _showCustomWidthDialog(context, breakdown),
      child: Row(
        children: [
          Icon(
            Icons.more_vert,
            color: const Color(0xFF00539D).withOpacity(0.7),
          ),
          // const SizedBox(width: 5),
          // Text(
          //   "View",
          //   style: TextStyle(color: const Color(0xFF00539D).withOpacity(0.7)),
          // ),
        ],
      ),
    );
  }
}

void _showCustomWidthDialog(
  BuildContext context,
  List<TransactionChannelBreakdown> breakdown,
) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        insetPadding: const EdgeInsets.all(15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: ChannelBreakdownView(breakdown: breakdown),
      );
    },
  );
}
