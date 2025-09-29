import 'package:auto_route/auto_route.dart';
import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:dkb_retail/features/common/dialog/custom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/ratelist_dummy.dart';
import '../controller/rates_providers.dart';

void showChooseCurrencySheet(BuildContext context) {
  CustomSheet.show(context: context, child: const ChooseCurrencySheet());
}

class ChooseCurrencySheet extends ConsumerStatefulWidget {
  const ChooseCurrencySheet({super.key});

  @override
  ConsumerState<ChooseCurrencySheet> createState() =>
      _ChooseCurrencySheetState();
}

class _ChooseCurrencySheetState extends ConsumerState<ChooseCurrencySheet> {
  final ScrollController _currencyScrollController = ScrollController();
  final Map<String, int> alphabetIndexMap = {};
  late List<String> alphabetList;

  String? selectedLetter;

  @override
  void initState() {
    super.initState();

    // sort currencies alphabetically
    rateList.sort((a, b) {
      final firstName = a["name"] ?? "";
      final secondName = b["name"] ?? "";
      return firstName.compareTo(secondName);
    });

    // create alphabet index map
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
  }

  void _scrollToAlphabet(String letter) {
    final targetIndex = alphabetIndexMap[letter];
    final uniqueAlphabetIndex = alphabetList.indexWhere(
      (element) => element == letter,
    );
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

    final letterHeight = box.size.height / alphabetList.length;
    int index = (local.dy ~/ letterHeight).clamp(0, alphabetList.length - 1);

    final letter = alphabetList[index];
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

    final filteredList = rateList
        .where(
          (item) =>
              item["code"]!.toLowerCase().contains(searchQuery.toLowerCase()) ||
              item["name"]!.toLowerCase().contains(searchQuery.toLowerCase()),
        )
        .toList();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: IconButton(
            onPressed: () {
              context.router.pop();
            },
            icon: const Icon(Icons.close, color: DefaultColors.white),
          ),
        ),
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
                  // Title
                  Padding(
                    padding: EdgeInsets.only(bottom: height * 0.015),
                    child: Text(
                      "Choose Currency",
                      style: TextStyle(
                        fontSize: width * 0.05,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade800,
                      ),
                    ),
                  ),

                  // Search bar
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,

                        icon: const Icon(Icons.search, color: Colors.black54),
                        hintText: "Search Currency",
                        hintStyle: TextStyle(fontSize: width * 0.035),
                      ),
                      onChanged: (val) {
                        ref.read(searchQueryProvider.notifier).state = val;
                      },
                    ),
                  ),

                  SizedBox(height: height * 0.02),

                  // Currency list + Alphabet list
                  SizedBox(
                    height: height * 0.7, // limit height in bottom sheet
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
                                  ? rateList[index]
                                  : rateList[index - 1];
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
                                  ListTile(
                                    leading: Text(
                                      item["flag"]!,
                                      style: TextStyle(fontSize: width * 0.08),
                                    ),
                                    title: Text(
                                      item["code"]!,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: width * 0.045,
                                      ),
                                    ),
                                    subtitle: Text(
                                      item["name"]!,
                                      style: TextStyle(fontSize: width * 0.035),
                                    ),
                                    trailing: Radio<String>(
                                      value: item["code"]!,
                                      groupValue: selectedCurrency,
                                      onChanged: (val) {
                                        ref
                                                .read(
                                                  selectedCurrencyProvider
                                                      .notifier,
                                                )
                                                .state =
                                            val!;
                                        Navigator.pop(context, val);
                                      },
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
                                onTapDown: (d) => _handleAlphabetDrag(
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
                  ),
                ],
              ),

              // Overlay selected letter
              if (selectedLetter != null)
                TweenAnimationBuilder<double>(
                  duration: const Duration(milliseconds: 300),
                  tween: Tween<double>(begin: 0, end: 1),
                  curve: Curves.easeInOut,
                  builder: (context, opacity, child) {
                    return Opacity(opacity: opacity, child: child);
                  },
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: DefaultColors.black.withAlpha(150),
                        borderRadius: BorderRadius.circular(
                          MediaQuery.of(context).size.width * 0.02,
                        ),
                      ),
                      child: Text(
                        selectedLetter!,
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
    );
  }
}
