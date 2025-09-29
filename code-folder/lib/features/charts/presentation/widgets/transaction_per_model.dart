import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../core/utils/ui_components/components/consts/date_range_picker.dart';
import '../../../../core/utils/ui_components/components/consts/filter_chip_list.dart';

class TransactionPerModel extends StatefulWidget {
  final List<DeviceTransactionData> data;
  final VoidCallback onRefresh;
  final List<String> channels;
  final List<String> serviceTypes;

  const TransactionPerModel({
    Key? key,
    required this.data,
    required this.onRefresh,
    required this.channels,
    required this.serviceTypes,
  }) : super(key: key);

  @override
  State<TransactionPerModel> createState() => _TransactionPerModelState();
}

class _TransactionPerModelState extends State<TransactionPerModel> {
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
                    'Transactions per Device Model',
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
                text: 'Device Model',
                textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
            ),
            primaryYAxis: NumericAxis(
              title: AxisTitle(
                text: 'Transaction Count',
                textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
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

  List<CartesianSeries<dynamic, String>> _buildChartSeries() {
    List<CartesianSeries<dynamic, String>> chartSeries = [];

    List<String> channels = ['RIB', 'RMB', 'IB', 'MB'];

    Map<String, List<DeviceData>> channelDataMap = {
      'RIB': [],
      'RMB': [],
      'IB': [],
      'MB': [],
    };

    for (var device in widget.data) {
      for (var channel in channels) {
        var transactionCount = device.channels
            .firstWhere((channelData) => channelData.channelId == channel,
                orElse: () => DeviceData(channel, 0))
            .transactionCount;

        channelDataMap[channel]
            ?.add(DeviceData(device.platform, transactionCount));
      }
    }

    // Add one series per channel
    for (var channel in channels) {
      chartSeries.add(
        ColumnSeries<DeviceData, String>(
          name: channel, // Channel name
          dataSource: channelDataMap[channel]!,
          xValueMapper: (DeviceData data, _) => data.channelId,
          yValueMapper: (DeviceData data, _) => data.transactionCount,
        ),
      );
    }

    return chartSeries;
  }
}

class DeviceTransactionData {
  final String platform;
  final List<DeviceData> channels;

  DeviceTransactionData(this.platform, this.channels);
}

class DeviceData {
  final String channelId;
  final int transactionCount;

  DeviceData(this.channelId, this.transactionCount);
}
