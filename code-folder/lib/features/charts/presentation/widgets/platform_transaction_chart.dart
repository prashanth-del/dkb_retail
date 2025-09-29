import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:dkb_retail/features/charts/presentation/widgets/sheet/multi_select_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../core/constants/asset_path/asset_path.dart';
import '../../../../core/utils/ui_components/components/consts/date_range_picker.dart';
import '../../../../core/utils/ui_components/components/consts/filter_chip_list.dart';
import '../../../../core/utils/ui_components/components/consts/filter_options.dart';
import '../../data/models/platform_transaction_dto.dart';
import '../../domain/entity/platform_transaction_entity.dart';
import '../../domain/entity/request/transaction_filter_req.dart';
import '../controller/notifier/get_platform_transaction_analysis_notifier.dart';

class PlatformTransactionChart extends ConsumerStatefulWidget {
  const PlatformTransactionChart({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PlatformTransactionChartState();
}

class _PlatformTransactionChartState
    extends ConsumerState<PlatformTransactionChart> {
  final List<String> _countSelectedChannels = ["All"];
  DateTime? _startDate;
  DateTime? _endDate;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    final start = DateTime.now().subtract(const Duration(days: 7));
    final end = DateTime.now();
    Future(
      () => ref
          .read(getPlatformTransactionAnalysisNotifierProvider.notifier)
          .fetch(
            TransactionFilterReq(
              type: "DATE_RANGE",
              startDate: _startDate != null
                  ? "${_startDate?.year}-${_startDate?.month}-${_startDate?.day}"
                  : "${start.year}-${start.month}-${start.day}",
              endDate: _endDate != null
                  ? "${_endDate?.year}-${_endDate?.month}-${_endDate?.day}"
                  : "${end.year}-${end.month}-${end.day}",
              channels: _countSelectedChannels.contains("All")
                  ? FilterOptions.fullChannelIds
                  : _countSelectedChannels,
            ),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: DefaultColors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ref
              .watch(getPlatformTransactionAnalysisNotifierProvider)
              .when(
                data: (data) => _buildChartContent(data),
                error: (error, _) => _buildError(error),
                loading: () => _buildLoading(),
              ),
        ),
      ),
    );
  }

  Column _buildError(Object error) {
    return Column(
      children: [
        _buildHeader(showRefreshIcon: true),
        UiServerError(
          lottieAssetPath: AssetPath.lottie.empty,
          errorMessage: "Error",
          description: "Unable to load data",
        ),
      ],
    );
  }

  Widget _buildHeader({bool showRefreshIcon = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const UiTextNew.h3Semibold("Transition By Platform"),
        if (showRefreshIcon)
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            onPressed: () => _loadData(),
          ),
      ],
    );
  }

  Widget _buildChartContent(PlatformTransactionAnalysisEntity data) {
    final largestTransactionCount = _getLargestTransactionCount(data);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: 10.0),
          DateRangePicker(
            selectedStartDate: _startDate,
            selectedEndDate: _endDate,
            onStartDateSelected: (start) {
              setState(() {
                _startDate = start;
                _endDate = null;
              });
            },
            onEndDateSelected: (endDate) {
              setState(() {
                _endDate = endDate;
              });
              _loadData();
            },
          ),
          const SizedBox(height: 15.0),
          _buildChannelSelection(),
          _buildChart(data, largestTransactionCount),
        ],
      ),
    );
  }

  Widget _buildChannelSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Channels',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            IconButton(
              onPressed: _showChannelSelectionSheet,
              icon: const Icon(Icons.tune),
            ),
          ],
        ),
        FilterChipList(
          channels: _countSelectedChannels.contains("All")
              ? FilterOptions.fullChannelIds
              : _countSelectedChannels,
          selectedChannels: _countSelectedChannels.contains("All")
              ? FilterOptions.fullChannelIds
              : _countSelectedChannels,
          onSelectionChanged: (value) {},
        ),
      ],
    );
  }

  void _showChannelSelectionSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return MultiSelectBottomSheet(
          items: FilterOptions.fullChannelIds,
          initialSelectedItems: _countSelectedChannels.toSet(),
          onSelected: (newSelectedItems) {
            setState(() {
              _countSelectedChannels.clear();
              _countSelectedChannels.addAll(newSelectedItems);
            });
            _loadData();
          },
        );
      },
    );
  }

  Widget _buildChart(
    PlatformTransactionAnalysisEntity data,
    double largestTransactionCount,
  ) {
    return SfCartesianChart(
      tooltipBehavior: TooltipBehavior(enable: true),
      legend: const Legend(isVisible: true),
      primaryXAxis: const CategoryAxis(
        maximumLabelWidth: 100,
        labelIntersectAction: AxisLabelIntersectAction.rotate45,
      ),
      primaryYAxis: NumericAxis(
        minimum: 0,
        maximum: largestTransactionCount,
        majorGridLines: const MajorGridLines(width: 0),
      ),
      series: _buildSeries(data),
    );
  }

  double _getLargestTransactionCount(PlatformTransactionAnalysisEntity data) {
    if (data.platforms == null || data.platforms!.isEmpty) {
      return 0;
    }

    return data.platforms!
        .expand((platform) => platform.channelBreakdown)
        .map((channel) => double.tryParse(channel.transactionCount) ?? 0)
        .fold<double>(0.0, (current, next) => current > next ? current : next);
  }

  Widget _buildLoading() {
    return const Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: [
          UIShimmerWidget.rectangle(),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: UIShimmerWidget.rectangle()),
              SizedBox(width: 50),
              Expanded(child: UIShimmerWidget.rectangle()),
            ],
          ),
          SizedBox(height: 20),
          UIShimmerWidget.rectangle(height: 200),
        ],
      ),
    );
  }

  List<CartesianSeries<PlatformChannelBreakdown, String>> _buildSeries(
    PlatformTransactionAnalysisEntity platformTransactions,
  ) {
    final allChannels = platformTransactions.platforms!
        .expand((platform) => platform.channelBreakdown)
        .map((channel) => channel.channelId)
        .toSet()
        .toList();

    final Map<String, Color> channelColors = {
      "MB": const Color(0xFFEA2027),
      "RIB": const Color(0xFF00B189),
      "IB": const Color(0xFF00539D),
      "RMB": const Color(0xFFFF9364),
    };

    return allChannels.map((channelId) {
      return ColumnSeries<PlatformChannelBreakdown, String>(
        name: channelId,
        color: channelColors[channelId],
        dataSource: platformTransactions.platforms?.expand((platform) {
          final breakdown = platform.channelBreakdown.firstWhere(
            (channel) => channel.channelId == channelId,
            orElse: () => PlatformChannelBreakdown(
              channelId: channelId,
              transactionCount: "0",
            ),
          );
          return [
            PlatformChannelBreakdown(
              channelId: breakdown.channelId,
              transactionCount: breakdown.transactionCount,
              transactionType: platform.transactionType,
            ),
          ];
        }).toList(),
        xValueMapper: (PlatformChannelBreakdown data, _) =>
            data.transactionType,
        yValueMapper: (PlatformChannelBreakdown data, _) =>
            double.parse(data.transactionCount),
      );
    }).toList();
  }
}
