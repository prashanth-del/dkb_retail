import 'package:flutter/material.dart';

import '../../../../../../core/utils/ui_components/components/src/ui_shimmer_widget.dart';

class TrasactionTableLoadingPlaceholder extends StatelessWidget {
  const TrasactionTableLoadingPlaceholder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const Row(
            children: [
              Expanded(child: UIShimmerWidget.rectangle(height: 30)),
              SizedBox(width: 10),
              Expanded(child: UIShimmerWidget.rectangle(height: 30)),
              SizedBox(width: 10),
              Expanded(child: UIShimmerWidget.rectangle(height: 30)),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: 20,
              itemBuilder: (context, index) => const Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Row(
                  children: [
                    Expanded(child: UIShimmerWidget.rectangle(height: 30)),
                    SizedBox(width: 10),
                    Expanded(child: UIShimmerWidget.rectangle(height: 30)),
                    SizedBox(width: 10),
                    Expanded(child: UIShimmerWidget.rectangle(height: 30)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
