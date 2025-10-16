import 'package:async_ui/async_ui.dart';
import 'package:auto_route/auto_route.dart';
import 'package:db_uicomponents/components.dart';
import 'package:db_uicomponents/styles.dart';
import 'package:dkb_retail/features/rates/data/models/profit_rates_model/get_profit_rates_request.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../../core/constants/app_strings/default_string.dart';
import '../../../common/presentation/components/auth_header_wrapper.dart';
import '../../../common/presentation/components/dialogs.dart';
import '../../domain/entities/profit_rates.dart';
import '../controller/state/profit_rates_notifier.dart';
import '../widgets/profit_tile.dart';

@RoutePage()
class ProfitRatesScreen extends ConsumerStatefulWidget {
  const ProfitRatesScreen({super.key});

  @override
  ConsumerState<ProfitRatesScreen> createState() => _ProfitRatesScreenState();
}

class _ProfitRatesScreenState extends ConsumerState<ProfitRatesScreen> {
  int selectedTabIndex = 0;

  static Map<String, String> productTypeMap = {
    "NTD": DefaultString.instance.productTimeDeposit,
    "SAV": DefaultString.instance.productSavings,
    "SSV": DefaultString.instance.productFaseel,
    "MSP": DefaultString.instance.productExceptionalSavingPlus,
    "PIA": DefaultString.instance.productProfitInAdvanceDeposit,
    "MSS": DefaultString.instance.productExceptionalSavings,
    "PSV": "PSV",
    "YSV": "YSV",
    "CAL": "CAL",
  };

  late final List<Map<String, String>> tabs;

  @override
  void initState() {
    super.initState();
    tabs = productTypeMap.entries
        .map((e) => {"code": e.key, "label": e.value})
        .toList();

    final request = GetProfitRatesRequest();

    Future.microtask(() => ref
        .read(profitRatesNotifierProvider.notifier)
        .fetchProfitRates(request: request));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final w = size.width;
    final h = size.height;

    return Scaffold(
      body: RxView<AsyncValue<ProfitRates>, ProfitRates>(
        stateProvider: profitRatesNotifierProvider,
        map: (state) => state,
        lockWhileLoading: false,
        loading: (_) => const Center(child: CircularProgressIndicator()),
        error: (ctx, err, _) => Center(child: Text(err.toString())),
        onError: (err, _) => showErrorDialog(err.toString(), context, ref),
        data: (ctx, rates) {
          // Map code to filtered rates
          final Map<String, List<dynamic>> filteredRatesMap = {
            "PSV": rates.PSV,
            "SSV": rates.SSV,
            "PIA": rates.PIA,
            "SAV": rates.SAV,
            "YSV": rates.YSV,
            "NTD": rates.NTD,
            "CAL": rates.CAL,
          };

          // Filter tabs that have data
          final availableTabs = tabs.where((tab) {
            final code = tab["code"]!;
            final list = filteredRatesMap[code] ?? [];
            return list.isNotEmpty;
          }).toList();

          // Handle empty tabs
          if (availableTabs.isEmpty) {
            return Center(child: Text(DefaultString.instance.noDataAvailable));
          }

          // Ensure selectedTabIndex is within bounds
          if (selectedTabIndex >= availableTabs.length) {
            selectedTabIndex = 0;
          }

          final code = availableTabs[selectedTabIndex]["code"]!;
          final filteredRates = filteredRatesMap[code] ?? [];

          // Tabs widget (horizontal scroll)
          final tabWidget = SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(vertical: h * 0.005),
            child: Row(
              children: availableTabs.asMap().entries.map((entry) {
                final index = entry.key;
                final tab = entry.value;
                final isSelected = selectedTabIndex == index;
                final tabCount = (filteredRatesMap[tab["code"]!] ?? []).length;

                return Padding(
                  padding: EdgeInsets.only(right: w * 0.02),
                  child: GestureDetector(
                    onTap: () => setState(() => selectedTabIndex = index),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: w * 0.04,
                        vertical: h * 0.01,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? DefaultColors.blue88
                            : Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Row(
                        children: [
                          Text(
                            tab["label"]!,
                            style: TextStyle(
                              color: DefaultColors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: w * 0.035,
                            ),
                          ),
                          SizedBox(width: w * 0.02),
                          Text(
                            "$tabCount",
                            style: TextStyle(
                              fontSize: w * 0.03,
                              fontWeight: FontWeight.bold,
                              color: DefaultColors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          );

          // Main body content
          final bodyContent = filteredRates.isEmpty
              ? Center(child: Text(DefaultString.instance.noDataAvailable))
              : ListView.builder(
            itemCount: filteredRates.length,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              final rateItem = filteredRates[index];
              return Padding(
                padding: EdgeInsets.only(bottom: h * 0.012),
                child: ProfitTile(
                  title: productTypeMap[rateItem.productType] ??
                      rateItem.productType,
                  tags: [
                    DefaultString.instance.tagRetail,
                    '${rateItem.productSubtype}M',
                    DefaultString.instance.currencyQar,
                  ],
                  rate:
                  '${double.tryParse(rateItem.rate)?.toStringAsFixed(2) ?? "0.00"}%',
                  date: formatDate(rateItem.rateCreationDate),
                  lastMonthDate: formatDate(rateItem.lastMonthDate),
                  tenure: '${rateItem.productSubtype} Months',
                  category: DefaultString.instance.categoryRetail,
                  currency: DefaultString.instance.currencyQar,
                ),
              );
            },
          );

          return AuthHeaderWrapper(
            headerText: DefaultString.instance.profitRatesTitle,
            tabs: tabWidget,
            withScroll: true,
            child: SizedBox(
              height: h * 0.75,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: w * 0.04),
                child: bodyContent,
              ),
            ),
          );
        },
      ),
    );
  }
}

String formatDate(String dateStr) {
  try {
    final date = DateTime.parse(dateStr);
    return DateFormat('dd/MM/yyyy').format(date);
  } catch (e) {
    return dateStr;
  }
}
