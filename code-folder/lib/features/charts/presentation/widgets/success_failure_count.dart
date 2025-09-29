import 'package:dkb_retail/features/charts/presentation/widgets/filterable_pie_chart.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/ui_components/components/consts/date_range_picker.dart';
import '../../../../core/utils/ui_components/components/consts/filter_chip_list.dart';

class SuccessFailureChart extends StatefulWidget {
  final Map<String, dynamic> rawData;
  final List<String> channels;
  final List<String> serviceTypes;

  const SuccessFailureChart({
    super.key,
    required this.rawData,
    required this.channels,
    required this.serviceTypes,
  });

  @override
  _SuccessFailureChartState createState() => _SuccessFailureChartState();
}

class _SuccessFailureChartState extends State<SuccessFailureChart> {
  late List<String> _selectedChannels;
  late List<String> _selectedServiceTypes;
  bool showFailureReasons = false;
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
  void initState() {
    super.initState();
    _selectedChannels = List.from(widget.channels); // Initially select all
    _selectedServiceTypes = List.from(
      widget.serviceTypes,
    ); // Initially select all
  }

  @override
  Widget build(BuildContext context) {
    final filteredData = filterTransactionData(
      rawData: widget.rawData,
      channels: _selectedChannels,
      serviceTypes: _selectedServiceTypes,
    );

    final failureReasons = widget.rawData['transactionAnalysis']['services']
        .where(
          (service) => _selectedServiceTypes.contains(service['serviceType']),
        )
        .expand((service) => (service['channelBreakdown'] as List<dynamic>))
        .where(
          (channel) => _selectedChannels.contains(
            (channel as Map<String, dynamic>)['channelId'],
          ),
        )
        .expand((channel) => (channel['failureReasons'] as List<dynamic>))
        .cast<Map<String, dynamic>>()
        .toList();

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          Row(
            children: [
              const Text(
                'Success Failure Counts',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.table_chart_rounded), // Data table icon
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) =>
                  //         TransactionDataTable(rawData: widget.rawData),
                  //   ),
                  // );
                },
              ),
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
          const SizedBox(height: 10.0),
          Column(
            children: [
              const Row(
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
              const Row(
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
          FilterablePieChart(
            rawData: widget.rawData,
            channels: _selectedChannels,
            serviceTypes: _selectedServiceTypes,
            onRefresh: () {},
          ),
          const Divider(),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFD9E5F0),
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {
              setState(() {
                showFailureReasons = !showFailureReasons;
              });
            },
            child: Text(
              showFailureReasons
                  ? 'Hide Failure Reasons'
                  : 'Show Failure Reasons',
            ),
          ),
          if (showFailureReasons)
            FailureReasonsList(failureReasons: failureReasons),
        ],
      ),
    );
  }
}

List<Map<String, dynamic>> filterTransactionData({
  required Map<String, dynamic> rawData,
  required List<String> channels,
  required List<String> serviceTypes,
}) {
  final filteredServices = rawData['transactionAnalysis']['services']
      .where((service) => serviceTypes.contains(service['serviceType']))
      .toList();

  int totalSuccess = 0;
  int totalFailure = 0;

  for (var service in filteredServices) {
    final channelBreakdown = service['channelBreakdown']
        .where((channel) => channels.contains(channel['channelId']))
        .toList();

    for (var channel in channelBreakdown) {
      totalSuccess += channel['successCount'] as int;
      totalFailure += channel['failureCount'] as int;
    }
  }

  return [
    {'label': 'Success', 'value': totalSuccess, 'color': Colors.green},
    {'label': 'Failure', 'value': totalFailure, 'color': Colors.red},
  ];
}

class FailureReasonsList extends StatelessWidget {
  final List<Map<String, dynamic>> failureReasons;

  const FailureReasonsList({super.key, required this.failureReasons});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: failureReasons.length,
      itemBuilder: (context, index) {
        final reason = failureReasons[index];
        return ListTile(
          title: Text(reason['reason']),
          trailing: Text('${reason['count']}'),
        );
      },
    );
  }
}
