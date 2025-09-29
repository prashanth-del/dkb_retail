import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../core/utils/ui_components/components/consts/date_range_picker.dart';
import '../../../../core/utils/ui_components/components/consts/filter_chip_list.dart';

class TransactionPerPlatfrom extends StatefulWidget {
  final List<PlatformTransactionData> data;
  final VoidCallback onRefresh;
  final List<String> channels;
  final List<String> serviceTypes;

  const TransactionPerPlatfrom({
    Key? key,
    required this.data,
    required this.onRefresh,
    required this.channels,
    required this.serviceTypes,
  }) : super(key: key);

  @override
  State<TransactionPerPlatfrom> createState() => _TransactionChartWidgetState();
}

class _TransactionChartWidgetState extends State<TransactionPerPlatfrom> {
  late List<String> _selectedChannels;
  late List<String> _selectedServiceTypes;
  DateTime? _startDate;

  DateTime? _endDate;
  void _onStartDateSelected(DateTime? date) {
    setState(() {
      _startDate = date;
    });
  }

  void _onEndDateSelected(DateTime? date) {
    setState(() {
      _endDate = date;
    });
  }

  @override
  void initState() {
    super.initState();
    _selectedChannels = List.from(widget.channels); // Initially select all
    _selectedServiceTypes =
        List.from(widget.serviceTypes); // Initially select all
  }

  void _onSelectionChanged(List<String> selectedChannels) {
    setState(() {
      _selectedChannels = selectedChannels;
    });
  }

  void _onSelectionChangedService(List<String> selectedChannels) {
    setState(() {
      _selectedServiceTypes = selectedChannels;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Column(
            children: [
              Row(
                children: [
                  Text(
                    'Transactions per Platform',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  Spacer(),
                  IconButton(
                    icon: const Icon(Icons.refresh_rounded), // Refresh icon
                    onPressed: () {},
                  ),
                ],
              ),
              DateRangePicker(
                selectedStartDate: _startDate,
                selectedEndDate: _endDate,
                onStartDateSelected: _onStartDateSelected,
                onEndDateSelected: _onEndDateSelected,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    'Channels',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  FilterChipList(
                    channels: widget.channels,
                    selectedChannels: _selectedChannels,
                    onSelectionChanged: _onSelectionChanged,
                  ),
                ],
              ),
            ],
          ),
          Column(
            children: [
              Row(
                children: [
                  Text(
                    'Service Type',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  FilterChipList(
                    channels: widget.serviceTypes,
                    selectedChannels: _selectedServiceTypes,
                    onSelectionChanged: _onSelectionChangedService,
                  ),
                ],
              ),
            ],
          ),
          const Divider(),
          SfCartesianChart(
            tooltipBehavior: TooltipBehavior(enable: true),
            primaryXAxis: CategoryAxis(
              title: AxisTitle(
                  text: 'Platforms',
                  textStyle:
                      TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
            ),
            primaryYAxis: NumericAxis(
              title: AxisTitle(
                  text: 'Transaction Count',
                  textStyle:
                      TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
            ),
            legend: Legend(
              isVisible: true,
              position: LegendPosition.top,
            ),
            series: _buildChartSeries(),
          ),
        ],
      ),
    );
  }

  List<CartesianSeries<dynamic, dynamic>> _buildChartSeries() {
    return widget.data.map((platform) {
      return ColumnSeries<dynamic, dynamic>(
        name: platform.platform,
        dataSource: platform.channels,
        xValueMapper: (dynamic data, _) => data.channelId,
        yValueMapper: (dynamic data, _) => data.transactionCount,
      );
    }).toList();
  }
}

class PlatformTransactionData {
  final String platform;
  final List<ChannelData> channels;

  PlatformTransactionData(this.platform, this.channels);
}

class ChannelData {
  final String channelId;
  final int transactionCount;

  ChannelData(this.channelId, this.transactionCount);
}
