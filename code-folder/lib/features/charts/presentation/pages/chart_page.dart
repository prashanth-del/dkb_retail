import 'package:auto_route/auto_route.dart';
import 'package:db_uicomponents/components.dart';
import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/asset_path/asset_path.dart';
import '../../../../core/utils/ui_components/components/src/ui_error.dart';
import '../../../common/components/auto_leading_widget.dart';
import '../../domain/entity/request/active_session_req.dart';
import '../controller/notifier/get_active_session_notifier.dart';
import '../widgets/active_sessions_chart.dart';
import '../widgets/platform_transaction_chart.dart';
import '../widgets/transaction_analysis/transaction_summary_analysis.dart';

@RoutePage()
class ChartPage extends ConsumerStatefulWidget {
  const ChartPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DashboardPageState();
}

class _DashboardPageState extends ConsumerState<ChartPage> {
  Future<void> _refreshData() async {
    Future(() => ref
        .read(getActiveSessionNotifierProvider.notifier)
        .fetch(const ActiveSessionReq()));
  }

  @override
  void initState() {
    super.initState();
    Future(() => ref
        .read(getActiveSessionNotifierProvider.notifier)
        .fetch(const ActiveSessionReq()));
  }

  @override
  Widget build(BuildContext context) {
    final activeSessionData = ref.watch(getActiveSessionNotifierProvider);
    return Scaffold(
      backgroundColor: DefaultColors.white_f3,
      appBar: const UIAppBar.secondary(
          title: "Realtime Analytics",
          autoLeadingWidget: AutoLeadingWidget()),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: UiCard(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: activeSessionData.when(
                  data: (activeSessionDto) {
                    return ActiveSessionsChart(
                      title: activeSessionDto.title,
                      xAxisCategories: activeSessionDto.xAxis.values,
                      xAxisTitle: activeSessionDto.xAxis.title,
                      yAxisTitle: activeSessionDto.yAxis.title,
                      yAxisValues: activeSessionDto.yAxis.values
                          .map((e) => int.parse(e))
                          .toList(),
                      seriesData: activeSessionDto.series.map((series) {
                        return ChartSeriesData(
                          series.name,
                          series.data.map((dataPoint) {
                            return SessionData(
                                dataPoint.x, int.parse(dataPoint.y));
                          }).toList(),
                        );
                      }).toList(),
                      onRefresh: _refreshData,
                    );
                  },
                  loading: () => _buildLoading(),
                  error: (e, stackTrace) => Column(
                    children: [UiServerError(
                      lottieAssetPath: AssetPath.lottie.empty,
                      errorMessage: "Error",
                      description: "Unable to load data",
                    ),],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16.0),
            // Graph

            const TransactionSummaryAnalysisChart(),

            const PlatformTransactionChart(),

            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Card(
            //       elevation: 3,
            //       color: Colors.white,
            //       child: TransactionPerModel(
            //           data: deviceData,
            //           channels: filters['channels']!,
            //           serviceTypes: filters['serviceTypes']!,
            //           onRefresh: () {})),
            // ),
          ],
        ),
      ),
    );
  }

  Text _buildErrror(Object error) => Text(error.toString());

  Widget _buildLoading() {
    return const Padding(
      padding: const EdgeInsets.all(10.0),
      child: const Column(
        children: [
          UIShimmerWidget.rectangle(),
          // SizedBox(
          //   height: 20,
          // ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Expanded(child: UIShimmerWidget.rectangle()),
          //     SizedBox(
          //       width: 50,
          //     ),
          //     Expanded(child: UIShimmerWidget.rectangle())
          //   ],
          // ),
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
