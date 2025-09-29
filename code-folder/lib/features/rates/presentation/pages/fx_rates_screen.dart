import 'package:auto_route/auto_route.dart';
import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:dkb_retail/features/rates/presentation/widgets/choose_currency_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/ratelist_dummy.dart';
import '../controller/rates_providers.dart';
import '../widgets/fx_currency_row_widget.dart';
import '../widgets/fx_rate_list.dart';

@RoutePage()
class FxRatesScreen extends ConsumerStatefulWidget {
  const FxRatesScreen({super.key});

  @override
  ConsumerState<FxRatesScreen> createState() => _FxRatesScreenState();
}

class _FxRatesScreenState extends ConsumerState<FxRatesScreen> {
  final ScrollController _currencyScrollController = ScrollController();

  final Map<String, int> alphabetIndexMap = {};
  late List<String> alphabetList;
  String? currentAlphabet;

  void swapCurrencies() {
    ref
        .read(topCurrenciesProvider.notifier)
        .update((list) => [list[1], list[0]]);
  }

  @override
  void initState() {
    super.initState();

    // arrange rates list alphabetically
    rateList.sort((a, b) {
      final firstName = a["name"] ?? "";
      final secondName = b["name"] ?? "";
      return firstName.compareTo(secondName);
    });

    // alphabet list + index map
    final Set<String> alphabetSet = {};
    for (int i = 0; i < rateList.length; i++) {
      final name = rateList[i]["name"];
      if (name != null && name.isNotEmpty) {
        final firstChar = name[0].toUpperCase();
        if (RegExp(r'[A-Z]').hasMatch(firstChar)) {
          alphabetSet.add(firstChar);
          alphabetIndexMap.putIfAbsent(firstChar, () => i);
        }
      }
    }
    alphabetList = alphabetSet.toList()..sort();

    print(alphabetIndexMap);
  }

  void _showLetter(String letter) {
    ref.read(fxlistSelectedAlphabetProvider.notifier).state = letter;
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted && ref.read(fxlistSelectedAlphabetProvider) == letter) {
        ref.read(fxlistSelectedAlphabetProvider.notifier).state = null;
      }
    });
  }

  void _scrollToAlphabet(String letter) {
    final targetIndex = alphabetIndexMap[letter];
    final uniqueAlphabetIndex = alphabetList.indexWhere(
      (element) => element == letter,
    );
    if (targetIndex != null) {
      final itemExtent = MediaQuery.of(context).size.height * 0.08;
      final alphabetHeight = MediaQuery.of(context).size.height * 0.035;
      _currencyScrollController.jumpTo(
        targetIndex * itemExtent + (uniqueAlphabetIndex * alphabetHeight),
      );
    }
  }

  void _handleAlphabetDrag(Offset globalPos, BuildContext context) {
    final RenderBox box =
        context.findRenderObject() as RenderBox; // alphabet list box
    final local = box.globalToLocal(globalPos);

    final letterHeight = box.size.height / alphabetList.length;
    int index = (local.dy ~/ letterHeight).clamp(0, alphabetList.length - 1);

    final letter = alphabetList[index];
    _showLetter(letter);
    _scrollToAlphabet(letter);
  }

  @override
  void dispose() {
    _currencyScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    final topCurrencies = ref.watch(topCurrenciesProvider);
    final selectedLetter = ref.watch(fxlistSelectedAlphabetProvider);
    final selectedCurrency = ref.watch(selectedCurrencyProvider);

    return Scaffold(
      backgroundColor: DefaultColors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: InkWell(
          onTap: () => context.router.pop(),
          child: const Icon(Icons.arrow_back, color: Colors.black87),
        ),
        title: Text(
          "FX Rates",
          style: TextStyle(
            color: DefaultColors.blue98,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(width * 0.04),
        child: Column(
          children: [
            // Exchange card
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              padding: EdgeInsets.all(width * 0.05),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  Container(
                    height: 160,
                    decoration: BoxDecoration(
                      color: DefaultColors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Stack(
                      children: [
                        // Reorderable list
                        ReorderableListView(
                          buildDefaultDragHandles: true,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          onReorder: (oldIndex, newIndex) {
                            final list = [...topCurrencies];
                            if (newIndex > oldIndex) newIndex--;
                            final item = list.removeAt(oldIndex);
                            list.insert(newIndex, item);
                            ref.read(topCurrenciesProvider.notifier).state =
                                list;
                          },
                          children: [
                            for (int i = 0; i < topCurrencies.length; i++)
                              Column(
                                key: ValueKey(topCurrencies[i]["code"]),
                                children: [
                                  if (topCurrencies[i]["code"] == "QAR")
                                    currencyRow(
                                      topCurrencies[i]["flag"]!,
                                      topCurrencies[i]["code"]!,
                                      topCurrencies[i]["rate"]!,
                                      width,
                                      height,
                                      istopBox: i == 0,
                                      withDropdown: false,
                                    )
                                  else
                                    currencyRow(
                                      getFlagForCode(selectedCurrency ?? "USA"),
                                      selectedCurrency ?? "USA",
                                      getRateForCode(selectedCurrency ?? "USA"),
                                      width,
                                      height,
                                      istopBox: i == 0,
                                      withDropdown: true,
                                      dropdownTap: () async {
                                        showChooseCurrencySheet(context);
                                      },
                                    ),
                                  if (i == 0)
                                    Container(
                                      color: Colors.grey.shade200,
                                      height: height * 0.005,
                                    ),
                                ],
                              ),
                          ],
                        ),
                        // Swap button
                        Align(
                          alignment: Alignment.centerLeft,
                          child: InkWell(
                            onTap: swapCurrencies,
                            child: Container(
                              margin: const EdgeInsets.only(left: 20),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey.shade200,
                              ),
                              padding: const EdgeInsets.all(5),
                              child: Icon(
                                Icons.autorenew,
                                color: DefaultColors.grey,
                                size: 25,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: height * 0.015),
                  Text(
                    "1 QAR = 2.73276 $selectedCurrency",
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      fontSize: width * 0.035,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: height * 0.02),

            Expanded(
              child: Stack(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 30,
                        child: ListView.builder(
                          itemCount: rateList.length,
                          controller: _currencyScrollController,
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            final previousItem = index == 0
                                ? rateList[index]
                                : rateList[index - 1];
                            final item = rateList[index];

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (index == 0 ||
                                    previousItem["name"]?[0] !=
                                        item["name"]?[0]) ...[
                                  Text(
                                    item["name"]?[0].toUpperCase() ?? 'A',
                                    style: TextStyle(
                                      color: DefaultColors.blue98,
                                      fontWeight: FontWeight.bold,
                                      fontSize:
                                          MediaQuery.of(
                                            context,
                                          ).size.aspectRatio *
                                          40,
                                    ),
                                  ),
                                  UiSpace.vertical(10),
                                ],
                                rateTile(
                                  item["flag"]!,
                                  item["code"]!,
                                  item["name"]!,
                                  item["buy"]!,
                                  item["sell"]!,
                                  width,
                                  height,
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.05),

                      /// Alphabet list with drag sync
                      Expanded(
                        flex: 1,
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            return GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onPanStart: (d) => _handleAlphabetDrag(
                                d.globalPosition,
                                context,
                              ),
                              onPanUpdate: (d) => _handleAlphabetDrag(
                                d.globalPosition,
                                context,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  for (final alphabet in alphabetList)
                                    Text(
                                      alphabet,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize:
                                            MediaQuery.of(
                                              context,
                                            ).size.aspectRatio *
                                            25,
                                      ),
                                    ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),

                  if (selectedLetter != null)
                    TweenAnimationBuilder<double>(
                      duration: const Duration(milliseconds: 300),
                      tween: Tween<double>(begin: 0, end: 1),
                      curve: Curves.easeInOut,
                      builder: (context, opacity, child) =>
                          Opacity(opacity: opacity, child: child),
                      child: Align(
                        alignment: Alignment.center,
                        child: Container(
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: DefaultColors.black.withAlpha(150),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            selectedLetter,
                            style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.aspectRatio * 90,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 🔹 Helpers to fetch flag/rate for selectedCurrency
String getFlagForCode(String code) {
  final item = rateList.firstWhere(
    (e) => e["code"] == code,
    orElse: () => {"flag": "🏳️"},
  );
  return item["flag"]!;
}

String getRateForCode(String code) {
  final item = rateList.firstWhere(
    (e) => e["code"] == code,
    orElse: () => {"sell": "0.000"},
  );
  return item["sell"]!;
}
