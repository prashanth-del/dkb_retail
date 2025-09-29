import 'package:auto_route/auto_route.dart';
import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../../../core/constants/asset_path/asset_path.dart';
import '../../../../../core/router/app_router.dart';
import '../../../../../core/utils/ui_components/components/consts/date_range_picker.dart';
import '../../../../../core/utils/ui_components/components/consts/filter_chip_list.dart';
import '../../../../../core/utils/ui_components/components/consts/filter_options.dart';
import '../../../../../core/utils/ui_components/components/src/ui_error.dart';
import '../../../domain/entity/request/transaction_filter_req.dart';
import '../../controller/notifier/get_trasaction_channels_notifer.dart';
import '../sheet/multi_select_bottom_sheet.dart';

class TransactionSummaryAnalysisChart extends ConsumerStatefulWidget {
  const TransactionSummaryAnalysisChart({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TransactionSummaryAnalysisChartState();
}

class _TransactionSummaryAnalysisChartState
    extends ConsumerState<TransactionSummaryAnalysisChart> {
  List<String> _countSelectedChannels = ["All"];

  DateTime? _startDate;

  DateTime? _endDate;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    final _start = DateTime.now().subtract(const Duration(days: 7));
    final _end = DateTime.now();
    Future(() => ref
        .read(getTrasactionChannelsNotiferProvider.notifier)
        .fetch(TransactionFilterReq(
          type: "DATE_RANGE",
          startDate: _startDate != null
              ? "${_startDate?.year}-${_startDate?.month}-${_startDate?.day}"
              : "${_start.year}-${_start.month}-${_start.day}",
          endDate: _endDate != null
              ? "${_endDate?.year}-${_endDate?.month}-${_endDate?.day}"
              : "${_end.year}-${_end.month}-${_end.day}",
          channels: _countSelectedChannels.contains("All")
              ? FilterOptions.channelIds
              : _countSelectedChannels,
        )));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: UiCard(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: ref.watch(getTrasactionChannelsNotiferProvider).when(
            data: (data) {
              double totalSuccess = data.trasactionChannels
                  .fold(0, (sum, channel) => sum + channel.success);
              double totalFailure = data.trasactionChannels
                  .fold(0, (sum, channel) => sum + channel.failure);

              final pieData = [
                ChartData('Success', totalSuccess, Colors.green),
                ChartData('Failure', totalFailure, Colors.red),
              ];

              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: _buildHeader(showTableIcon: true),
                    ),
                    const SizedBox(height: 10.0),
                    // Date Range Pickers
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
                    // Channel Filters
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                                constraints: const BoxConstraints(),
                                padding: EdgeInsets.zero,
                                style: const ButtonStyle(
                                  tapTargetSize: MaterialTapTargetSize
                                      .shrinkWrap, // the '2023' part
                                ),
                                onPressed: () {
                                  showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    builder: (context) {
                                      return MultiSelectBottomSheet(
                                        items: FilterOptions.channelIds,
                                        initialSelectedItems:
                                            _countSelectedChannels.toSet(),
                                        onSelected: (newSelectedItems) {
                                          setState(() {
                                            _countSelectedChannels.clear();
                                            _countSelectedChannels
                                                .addAll(newSelectedItems);
                                          });
                                          _loadData();
                                        },
                                      );
                                    },
                                  );
                                },
                                icon: const Icon(Icons.tune))
                            // const SizedBox(height: 10.0),
                          ],
                        ),
                        FilterChipList(
                          channels: _countSelectedChannels.contains("All")
                              ? FilterOptions.channelIds
                              : _countSelectedChannels,
                          selectedChannels:
                              _countSelectedChannels.contains("All")
                                  ? FilterOptions.channelIds
                                  : _countSelectedChannels,
                          onSelectionChanged: (value) {},
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SfCircularChart(
                            tooltipBehavior: TooltipBehavior(enable: true),
                            legend: const Legend(isVisible: true),
                            series: <CircularSeries>[
                              PieSeries<ChartData, String>(
                                dataSource: pieData,
                                pointColorMapper: (ChartData data, _) =>
                                    data.color,
                                xValueMapper: (ChartData data, _) =>
                                    data.status,
                                yValueMapper: (ChartData data, _) => data.count,
                                dataLabelSettings:
                                    const DataLabelSettings(isVisible: true),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
            error: (error, _) => _buildError(error),
            loading: () => _buildLoading()),
      ),
    );
  }

  _buildError(Object error) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          _buildHeader(showRefreshIcon: true),
          UiServerError(
            lottieAssetPath: AssetPath.lottie.empty,
            errorMessage: "Error",
            description: "Unable to load data",
          )
        ],
      ),
    );
  }

  Widget _buildHeader(
      {bool showTableIcon = false, bool showRefreshIcon = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        UiTextNew.h3Semibold(
          "Success/Failure Count",
        ),
        Row(
          children: [
            if (showRefreshIcon)
              GestureDetector(
                child: const Icon(Icons.refresh_rounded),
                onTap: () => _loadData(),
              ),
            if (showTableIcon && showRefreshIcon)
              SizedBox(
                width: 8,
              ),
            if (showTableIcon)
              GestureDetector(
                child: const Icon(Icons.table_view), // Refresh icon
                onTap: () {
                  context.router.push(TransactionDataTableRoute());
                  ;
                },
              ),
          ],
        )
      ],
    );
  }

  Widget _buildLoading() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          UIShimmerWidget.rectangle(),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: UIShimmerWidget.rectangle()),
              SizedBox(
                width: 50,
              ),
              Expanded(child: UIShimmerWidget.rectangle())
            ],
          ),
          SizedBox(
            height: 20,
          ),
          UIShimmerWidget.rectangle(
            height: 200,
          ),
        ],
      ),
    );
  }
}

class ChartData {
  final String status;
  final double count;
  final Color color;

  ChartData(this.status, this.count, this.color);
}
