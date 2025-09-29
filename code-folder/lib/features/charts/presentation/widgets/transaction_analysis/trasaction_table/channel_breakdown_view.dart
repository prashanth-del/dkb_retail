import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:flutter/material.dart';

import '../../../../data/models/transaction_analysis_dto.dart';

class ChannelBreakdownView extends StatelessWidget {
  final List<TransactionChannelBreakdown> breakdown;

  const ChannelBreakdownView({Key? key, required this.breakdown})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final filteredBreakdown =
        breakdown.where((breaks) => breaks.failureReasons.isNotEmpty).toList();

    return Container(
      padding: const EdgeInsets.all(12),
      height: context.screenHeight / 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),
          const SizedBox(height: 12),
          if (filteredBreakdown.isEmpty)
            Center(
              child: UiTextNew.b14Medium("No Failure Found"),
            ),
          if (filteredBreakdown.isNotEmpty)
            Expanded(
              child: ListView.builder(
                itemCount: filteredBreakdown.length,
                itemBuilder: (context, index) =>
                    _buildBreakdownCard(filteredBreakdown[index]),
              ),
            ),
        ],
      ),
    );
  }

  Row _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Reason',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.close),
        ),
      ],
    );
  }

  Widget _buildBreakdownCard(TransactionChannelBreakdown channel) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      color: const Color(0xFF00539D).withOpacity(0.7),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Channel ID: ${channel.channelId}',
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.white),
            ),
            const SizedBox(height: 8),
            const Text('Failure Reasons:',
                style: TextStyle(color: Colors.white)),
            ...channel.failureReasons.map((reason) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Failure Count: ${reason.count}',
                        style: const TextStyle(color: Colors.white)),
                    Text('Failure Message: ${reason.reason}',
                        style: const TextStyle(color: Colors.white)),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
