import 'dart:convert';
import 'package:auto_route/auto_route.dart';
import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:dkb_retail/features/common/presentation/dialog/custom_sheet.dart';
import 'package:dkb_retail/features/rates/presentation/controller/state/rates_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_strings/default_string.dart';
import '../../../../core/i18n/controller/i18n_notifiers.dart';
import '../controller/rates_providers.dart';

Future<String?> showChooseCurrencySheet(BuildContext context) {
  return CustomSheet.show<String?>(
    isDismissible: false,
    context: context,
    child: const ChooseCurrencySheet(),
  );
}

final flagListProvider = FutureProvider<List<Map<String, dynamic>>>((ref) async {
  final data = await rootBundle.loadString('assets/json/flag.json');
  final jsonResult = json.decode(data);
  return List<Map<String, dynamic>>.from(jsonResult['flags']);
});

class ChooseCurrencySheet extends ConsumerStatefulWidget {
  const ChooseCurrencySheet({super.key});

  @override
  ConsumerState<ChooseCurrencySheet> createState() => _ChooseCurrencySheetState();
}

class _ChooseCurrencySheetState extends ConsumerState<ChooseCurrencySheet> {
  final ScrollController _currencyScrollController = ScrollController();
  final Map<String, int> alphabetIndexMap = {};
  late List<String> alphabetList;
  String? selectedLetter;
  bool isArabic = false;


  void _scrollToAlphabet(String letter) {
    final targetIndex = alphabetIndexMap[letter];
    final uniqueAlphabetIndex = alphabetList.indexOf(letter);
    if (targetIndex != null) {
      final itemExtent = MediaQuery.of(context).size.height * 0.08;
      final alphabetHeight = MediaQuery.of(context).size.height * 0.033;
      _currencyScrollController.jumpTo(
        targetIndex * itemExtent + (uniqueAlphabetIndex * alphabetHeight),
      );
      _showLetter(letter);
    }
  }

  void _handleAlphabetDrag(Offset globalPos, BuildContext context) {
    final RenderBox box = context.findRenderObject() as RenderBox;
    final local = box.globalToLocal(globalPos);
    final totalHeight = box.size.height;
    final letterHeight = scale(14) * 1.2;
    final columnHeight = letterHeight * alphabetList.length;
    final topPadding = (totalHeight - columnHeight) / 2;
    final dy = local.dy - topPadding;
    int index = (dy ~/ letterHeight).clamp(0, alphabetList.length - 1);
    final letter = alphabetList[index];
    _showLetter(letter);
    _scrollToAlphabet(letter);
  }

  void _showLetter(String letter) {
    setState(() => selectedLetter = letter);
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted && selectedLetter == letter) {
        setState(() => selectedLetter = null);
      }
    });
  }

  double scale(double size) {
    final screenSize = MediaQuery.of(context).size;
    const baseWidth = 390.0;
    const baseHeight = 844.0;

    final scaleW = screenSize.width / baseWidth;
    final scaleH = screenSize.height / baseHeight;
    return size * (scaleW < scaleH ? scaleW : scaleH);
  }

  @override
  void dispose() {
    _currencyScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final searchQuery = ref.watch(searchQueryProvider);
    final selectedCurrency = ref.watch(selectedCurrencyProvider);
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    final flagListAsync = ref.watch(flagListProvider);
    final fxRatesState = ref.watch(ratesNotifierProvider);
    isArabic = ref.watch(localePodProvider).languageCode == 'ar';


    return fxRatesState.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, _) => Center(child: Text(err.toString())),
      data: (rates) {
        return flagListAsync.when(
          data: (flagList) {
            // 🔹 Merge API data with flagList
            final mergedList = rates.map((rate) {
              final flagEntry = flagList.firstWhere(
                    (e) => e['code'] == rate.isoCode,
                orElse: () => {
                  'flag': 'default.png',
                  'name': rate.curName,                },
              );
              return {
                'code': rate.isoCode,
                'name':(rate.curName.isNotEmpty ? rate.curName : ''),
                'flag': flagEntry['flag'],
              };
            }).toList();

            // 🔹 Sort alphabetically
            mergedList.sort((a, b) => a['name'].compareTo(b['name']));

            // Build alphabet map
            alphabetIndexMap.clear();
            final Set<String> alphabetSet = {};
            for (int i = 0; i < mergedList.length; i++) {
              final name = mergedList[i]['name'];
              if (name.isNotEmpty) {
                final firstChar = name[0].toUpperCase();
                if (isArabic) {
                  // Allow Arabic letters (ا to ي)
                  if (RegExp(r'[\u0621-\u064A]').hasMatch(firstChar)) {
                    alphabetSet.add(firstChar);
                    alphabetIndexMap.putIfAbsent(firstChar, () => i);
                  }
                } else {
                  // Default to English A–Z
                  if (RegExp(r'[A-Z]').hasMatch(firstChar)) {
                    alphabetSet.add(firstChar);
                    alphabetIndexMap.putIfAbsent(firstChar, () => i);
                  }
                }
              }
            }
            alphabetList = alphabetSet.toList()..sort();

            // 🔹 Apply search filter
            final filteredList = mergedList.where((item) {
              return item['code'].toLowerCase().contains(searchQuery.toLowerCase()) ||
                  item['name'].toLowerCase().contains(searchQuery.toLowerCase());
            }).toList();

            return SafeArea(
              top: true,
              bottom: false,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Align(
                  //   alignment: Alignment.centerRight,
                  //   child: IconButton(
                  //     onPressed: () => context.router.pop(),
                  //     icon: const Icon(Icons.close, color: DefaultColors.white),
                  //   ),
                  // ),
                  Container(
                    padding: EdgeInsets.all(width * 0.04),
                    decoration: const BoxDecoration(
                      color: DefaultColors.white,
                      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                    ),
                    child: Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child:
                              Container(
                                margin: EdgeInsets.only(bottom: height * 0.01),
                                width: width * 0.12,
                                height: height * 0.005,
                                decoration: BoxDecoration(
                                  color: DefaultColors.grayF9,
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: height * 0.015),
                              child: Text(
                                DefaultString.instance.chooseCurrency,
                                style: TextStyle(
                                  fontSize: width * 0.05,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue.shade800,
                                ),
                              ),
                            ),

                            // Search bar
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: width * 0.04,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: TextField(
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  icon: const Icon(
                                    Icons.search,
                                    color: Colors.black54,
                                  ),
                                  hintText: "Search Currency",
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  hintStyle: TextStyle(fontSize: width * 0.035),
                                ),
                                onChanged: (val) {
                                  ref.read(searchQueryProvider.notifier).state =
                                      val;
                                },
                              ),
                            ),

                            SizedBox(height: height * 0.02),

                            // Currency + Alphabet list
                            SizedBox(
                              height: height * 0.7,
                              child: Row(
                                children: [
                                  // Currency list
                                  Expanded(
                                    flex: 30,
                                    child: ListView.builder(
                                      controller: _currencyScrollController,
                                      itemCount: filteredList.length,
                                      itemBuilder: (context, index) {
                                        final item = filteredList[index];
                                        final previousItem = index == 0
                                            ? filteredList[index]
                                            : filteredList[index - 1];

                                        return Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            if (index == 0 ||
                                                previousItem['name'][0] !=
                                                    item['name'][0]) ...[
                                              Text(
                                                item['name'][0].toUpperCase(),
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
                                            InkWell(
                                              onTap: () {
                                                ref
                                                    .read(
                                                  selectedCurrencyProvider
                                                      .notifier,
                                                )
                                                    .state =
                                                item['code'];
                                                Navigator.pop(
                                                  context,
                                                  item['code'],
                                                );
                                              },
                                              child: ListTile(
                                                leading: Image.asset(
                                                  'assets/images/flags/${item['flag']}',
                                                  width: width * 0.1,
                                                  height: width * 0.09,
                                                  fit: BoxFit.contain,
                                                ),
                                                title: Text(
                                                  item['code'],
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: width * 0.045,
                                                    color: DefaultColors.black,
                                                  ),
                                                ),
                                                subtitle: Text(
                                                  item['name'],
                                                  style: TextStyle(
                                                    fontSize: width * 0.035,
                                                  ),
                                                ),
                                                trailing:
                                                selectedCurrency ==
                                                    item['code']
                                                    ? const Icon(
                                                  Icons.check,
                                                  color: DefaultColors
                                                      .blueprimary,
                                                ) // show a checkmark
                                                    : null,
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                  SizedBox(width: width * 0.02),

                                  // Alphabet list
                                  Expanded(
                                    flex: 1,
                                    child: Listener(
                                      behavior: HitTestBehavior.opaque,
                                      onPointerDown: (_) {},
                                      onPointerMove: (_) {},
                                      onPointerUp: (_) {},
                                      onPointerCancel: (_) {},
                                      child: LayoutBuilder(
                                        builder: (context, constraints) {
                                          return GestureDetector(
                                            behavior: HitTestBehavior.opaque,
                                            onPanStart: (d) =>
                                                _handleAlphabetDrag(
                                                  d.globalPosition,
                                                  context,
                                                ),
                                            onPanUpdate: (d) =>
                                                _handleAlphabetDrag(
                                                  d.globalPosition,
                                                  context,
                                                ),
                                            onTapDown: (d) =>
                                                _handleAlphabetDrag(
                                                  d.globalPosition,
                                                  context,
                                                ),
                                            child: Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              children: [
                                                for (final alphabet
                                                in alphabetList)
                                                  Text(
                                                    alphabet,
                                                    style: TextStyle(
                                                      fontWeight:
                                                      FontWeight.bold,
                                                      color:
                                                      DefaultColors.black,
                                                      fontSize: scale(12),
                                                    ),
                                                  ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        // Overlay selected letter
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
                                  borderRadius: BorderRadius.circular(
                                    width * 0.02,
                                  ),
                                ),
                                child: Text(
                                  selectedLetter!,
                                  style: TextStyle(
                                    fontSize:
                                    MediaQuery.of(
                                      context,
                                    ).size.aspectRatio *
                                        90,
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
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text("Error loading flags")),
        );
      },
    );
  }
}
