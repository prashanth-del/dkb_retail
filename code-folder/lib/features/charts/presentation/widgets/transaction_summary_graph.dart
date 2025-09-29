import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class TransactionSummaryGraph extends StatelessWidget {
  final Map<String, dynamic> transactionResponse;
  final VoidCallback onRefresh;

  const TransactionSummaryGraph({
    Key? key,
    required this.transactionResponse,
    required this.onRefresh,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final List<TransactionsData> webTransactions = [];
    final List<TransactionsData> mobileTransactions = [];

    final channels = transactionResponse['transactionSummary']['channels'] as List<dynamic>;

    for (var channel in channels) {
      final channelName = channel['channelId'] as String;
      webTransactions.add(TransactionsData(
        channelName,
        channel['webTransactions'] as int,
      ));
      mobileTransactions.add(TransactionsData(
        channelName,
        channel['mobileTransactions'] as int,
      ));
    }

    return SfCartesianChart(
      primaryXAxis: CategoryAxis(
        title: AxisTitle(text: "Channel",textStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500
        )),
      ),
      primaryYAxis: NumericAxis(
        title: AxisTitle(text: 'Transaction',textStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500
        )),
      ),

      legend: Legend(isVisible: true,),
      tooltipBehavior: TooltipBehavior(enable: true),
      series: <LineSeries<TransactionsData, String>>[

        LineSeries<TransactionsData, String>(
          name: 'Web Transactions',
          dataSource: webTransactions,
          xValueMapper: (TransactionsData data, _) => data.channelName,
          yValueMapper: (TransactionsData data, _) => data.transactionCount,
          markerSettings: const MarkerSettings(isVisible: true),
        ),
        // Mobile Transactions
        LineSeries<TransactionsData, String>(
          name: 'Mobile Transactions',
          dataSource: mobileTransactions,
          xValueMapper: (TransactionsData data, _) => data.channelName,
          yValueMapper: (TransactionsData data, _) => data.transactionCount,
          markerSettings: const MarkerSettings(isVisible: true),
        ),
      ],
    );
  }
}

// Helper class to represent transaction data
class TransactionsData {
  final String channelName;
  final int transactionCount;

  TransactionsData(this.channelName, this.transactionCount);
}
