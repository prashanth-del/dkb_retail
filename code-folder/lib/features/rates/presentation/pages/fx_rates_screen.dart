import 'dart:convert';
import 'package:async_ui/async_ui.dart';
import 'package:auto_route/auto_route.dart';
import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:dkb_retail/features/rates/presentation/controller/state/rates_notifier.dart';
import 'package:dkb_retail/features/rates/presentation/widgets/choose_currency_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_strings/default_string.dart';
import '../../../../core/i18n/controller/i18n_notifiers.dart';
import '../../../common/presentation/components/auth_header_wrapper.dart';
import '../../../common/presentation/components/dialogs.dart';
import '../../../transfer/data/model/flag_model.dart';
import '../../data/models/fx_rates_model/get_fx_rates_request.dart';
import '../../domain/entities/fx_rates.dart';
import '../controller/rates_providers.dart';
import '../widgets/fx_currency_row_widget.dart';
import '../widgets/fx_rate_list.dart';

@RoutePage()
class FxRatesScreen extends ConsumerStatefulWidget {
  const FxRatesScreen({super.key});

  @override
  ConsumerState<FxRatesScreen> createState() => _FxRatesScreenState();
}
final fxAlphabetProvider = StateProvider<List<String>>((ref) => []);

class _FxRatesScreenState extends ConsumerState<FxRatesScreen> {
  final ScrollController _currencyScrollController = ScrollController();
  final Map<String, int> alphabetIndexMap = {};
  // late List<String> alphabetList;
  String? currentAlphabet;
  late TextEditingController _qarController;
  double enteredQarValue = 1.0; // default multiplier
  late FocusNode _qarFocusNode;
  bool isArabic = false;
  late List<String> alphabetList = [];
  late final FutureProvider<List<Flag>> flagProvider =
  FutureProvider<List<Flag>>((ref) async {
    return await Flag.loadFlags();
  });


  double scale(double size) {
    final screenSize = MediaQuery.of(context).size;
    const baseWidth = 390.0;
    const baseHeight = 844.0;

    final scaleW = screenSize.width / baseWidth;
    final scaleH = screenSize.height / baseHeight;
    return size * (scaleW < scaleH ? scaleW : scaleH);
  }

  void swapCurrencies() {
    ref.read(topCurrenciesProvider.notifier).update((list) => [list[1], list[0]]);
  }

  void _setupAlphabetList(List<FxRates> rates) {
    final Set<String> alphabetSet = {};
    alphabetIndexMap.clear();

    for (int i = 0; i < rates.length; i++) {
      final name = rates[i].curName;
      if (name.isNotEmpty) {
        final firstChar = name[0].toUpperCase();
        final regex = isArabic ? RegExp(r'[\u0621-\u064A]') : RegExp(r'[A-Z]');
        if (regex.hasMatch(firstChar)) {
          alphabetSet.add(firstChar);
          alphabetIndexMap.putIfAbsent(firstChar, () => i);
        }
      }
    }

    ref.read(fxAlphabetProvider.notifier).state = alphabetSet.toList()..sort();
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
    final sortedRates = ref.read(ratesNotifierProvider).maybeWhen(
      data: (rates) => [...rates]..sort((a, b) => a.curName.compareTo(b.curName)),
      orElse: () => [],
    );

    double offset = 0;
    final itemHeight = scale(65);
    final headerHeight = scale(28);

    for (int i = 0; i < sortedRates.length; i++) {
      final currentName = sortedRates[i].curName;
      final prevName = i > 0 ? (sortedRates[i - 1].curName) : "";
      if (currentName.isEmpty) continue;

      final currentLetter = currentName[0].toUpperCase();
      final prevLetter = prevName.isNotEmpty ? prevName[0].toUpperCase() : "";
      final showHeader = i == 0 || currentLetter != prevLetter;

      if (currentLetter == letter) {
        if (showHeader) offset += headerHeight;
        break;
      }

      offset += itemHeight;
      if (showHeader) offset += headerHeight;
    }

    _currencyScrollController.jumpTo(offset);
  }

  void _handleAlphabetDrag(Offset globalPos, BuildContext context) {
    final alphabetList = ref.read(fxAlphabetProvider);
    if (alphabetList.isEmpty) return;
    final RenderBox box = context.findRenderObject() as RenderBox;
    final local = box.globalToLocal(globalPos);
    final totalHeight = box.size.height;
    final letterHeight = scale(12) * 1.2;
    final columnHeight = letterHeight * alphabetList.length;
    final topPadding = (totalHeight - columnHeight) / 2;
    final dy = local.dy - topPadding;
    int index = (dy ~/ letterHeight).clamp(0, alphabetList.length - 1);
    final letter = alphabetList[index];
    _showLetter(letter);
    _scrollToAlphabet(letter);
  }

  @override
  void initState() {
    super.initState();
    _qarController = TextEditingController(text: "1.00");
    _qarFocusNode = FocusNode();
    _qarController.addListener(() {
      final text = _qarController.text.trim();
      if (text.isNotEmpty) {
        final val = double.tryParse(text) ?? 1.0;
        setState(() {
          enteredQarValue = val;
        });
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final notifier = ref.read(ratesNotifierProvider.notifier);
      notifier.fetchRates(
        request: GetFxRatesRequest(),
      );
    });
  }

  @override
  void dispose() {
    _qarController.dispose();
    _qarFocusNode.dispose();
    _currencyScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final topCurrencies = ref.watch(topCurrenciesProvider);
    final selectedLetter = ref.watch(fxlistSelectedAlphabetProvider);
    final selectedCurrency = ref.watch(selectedCurrencyProvider);
    final flagsAsync = ref.watch(flagProvider);
    isArabic = ref.watch(localePodProvider).languageCode == 'ar';

    return RxView<AsyncValue<List<FxRates>>, List<FxRates>>(
      stateProvider: ratesNotifierProvider,
      map: (state) => state,
      lockWhileLoading: false,
      loading: (ctx) => const Center(child: CircularProgressIndicator()),
      error: (ctx, err, _) => Center(child: Text(err.toString())),
      onError: (err, _) => showErrorDialog(err.toString(), context, ref),
      onData: (rates) {
        _setupAlphabetList([...rates]..sort((a, b) => a.curName.compareTo(b.curName)));
      },
      data: (ctx, rates) {
        final sortedRates = [...rates]..sort((a, b) => a.curName.compareTo(b.curName));
        return Scaffold(
          backgroundColor: DefaultColors.white,
          body: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: AuthHeaderWrapper(
              headerText: DefaultString.instance.fxRatesTitle,
              withScroll: true,
              child: Padding(
                padding: EdgeInsets.all(scale(16)),
                child: flagsAsync.when(
                  data: (flags) {
                    return Column(
                      children: [
                        // 🔹 Top Exchange Card
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 500),
                          padding: EdgeInsets.all(scale(20)),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Container(
                                  height: scale(130),
                                  color: DefaultColors.white,
                                  child: Stack(
                                    children: [
                                      ReorderableListView(
                                        buildDefaultDragHandles: true,
                                        shrinkWrap: true,
                                        physics: const NeverScrollableScrollPhysics(),
                                        onReorder: (oldIndex, newIndex) {
                                          final list = [...topCurrencies];
                                          if (newIndex > oldIndex) newIndex--;
                                          final item = list.removeAt(oldIndex);
                                          list.insert(newIndex, item);
                                          ref.read(topCurrenciesProvider.notifier).state = list;
                                        },
                                        children: [
                                          for (int i = 0; i < topCurrencies.length; i++)
                                            Container(
                                              key: ValueKey(topCurrencies[i]["code"]),
                                              decoration: BoxDecoration(
                                                color: DefaultColors.white,
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(i == 0 ? 20 : 0),
                                                  topRight: Radius.circular(i == 0 ? 20 : 0),
                                                  bottomLeft: Radius.circular(i == topCurrencies.length - 1 ? 20 : 0),
                                                  bottomRight: Radius.circular(i == topCurrencies.length - 1 ? 20 : 0),
                                                ),
                                              ),
                                              child: Column(
                                                children: [
                                                  currencyRow(
                                                    context,
                                                    getFlagFromModel(flags, topCurrencies[i]["code"]!),
                                                    topCurrencies[i]["code"]!,
                                                    (double.parse(topCurrencies[i]["rate"]!) * enteredQarValue).toStringAsFixed(2),
                                                    scale(390),
                                                    scale(844),
                                                    _qarFocusNode,
                                                    istopBox: i == 0,
                                                    withDropdown: topCurrencies[i]["code"] != "QAR",
                                                    dropdownTap: topCurrencies[i]["code"] != "QAR"
                                                        ? () async {
                                                      _qarFocusNode.unfocus();
                                                      final selected = await showChooseCurrencySheet(context);
                                                      ref.read(searchQueryProvider.notifier).state = "";
                                                      if (selected != null) {
                                                        ref.read(topCurrenciesProvider.notifier).update((list) {
                                                          final newList = [...list];
                                                          newList[i]["code"] = selected;
                                                          newList[i]["rate"] = getRateForCode(ref, selected);
                                                          return newList;
                                                        });
                                                        ref.read(selectedCurrencyProvider.notifier).state = selected;
                                                      }
                                                    }
                                                        : null,
                                                    controller: topCurrencies[i]["code"] == "QAR" ? _qarController : null,
                                                  ),
                                                  if (i != topCurrencies.length - 1)
                                                    Container(
                                                      color: Colors.grey.shade200,
                                                      height: scale(2),
                                                    ),
                                                ],
                                              ),
                                            ),
                                        ],
                                      ),
                                      // Swap button
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: InkWell(
                                          onTap: swapCurrencies,
                                          child: Container(
                                            margin: EdgeInsets.only(left: scale(10), bottom: scale(10)),
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.grey.shade200,
                                            ),
                                            padding: EdgeInsets.all(scale(5)),
                                            child: Icon(
                                              Icons.autorenew,
                                              color: DefaultColors.grey,
                                              size: scale(20),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: scale(12)),
                              Text(
                                "$enteredQarValue QAR = ${(enteredQarValue * double.parse(getRateForCode(ref, selectedCurrency ?? "USD"))).toStringAsFixed(2)} $selectedCurrency",
                                style: TextStyle(
                                  color: Colors.grey.shade700,
                                  fontSize: scale(14),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: scale(16)),
                        // 🔹 FX Rate List
                        _buildFxRateList(sortedRates, flags),
                      ],
                    );
                  },
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (e, _) => Center(child: Text(DefaultString.instance.someThingError)),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildFxRateList(List<FxRates> sortedRates, List<Flag> flags) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.55,
      ),
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 28,
                child: ListView.builder(
                  itemCount: sortedRates.length,
                  controller: _currencyScrollController,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final item = sortedRates[index];
                    final currentLetter = item.curName[0].toUpperCase();
                    final prevLetter = index > 0 ? sortedRates[index - 1].curName.toUpperCase() : "";
                    final showHeader = index == 0 || currentLetter != prevLetter;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (showHeader)
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: scale(8)),
                            child: Text(
                              currentLetter,
                              style: TextStyle(
                                color: DefaultColors.blue98,
                                fontWeight: FontWeight.bold,
                                fontSize: scale(18),
                              ),
                            ),
                          ),
                        rateTile(
                          context,
                          getFlagAndNameFromModel(flags, item.isoCode).flag,
                          item.isoCode,
                          item.curName,
                          ((double.tryParse(item.ttBuy) ?? 0) * enteredQarValue).toStringAsFixed(2),
                          ((double.tryParse(item.ttSell) ?? 0) * enteredQarValue).toStringAsFixed(2),
                          scale(390),
                          scale(844),
                        ),
                      ],
                    );
                  },
                ),
              ),
              Expanded(
                flex: 1,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final alphabetList = ref.watch(fxAlphabetProvider);
                    return GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onPanStart: (d) => _handleAlphabetDrag(d.globalPosition, context),
                      onPanUpdate: (d) => _handleAlphabetDrag(d.globalPosition, context),
                      onTapDown: (d) => _handleAlphabetDrag(d.globalPosition, context),
                      child: SingleChildScrollView(
                        physics: const NeverScrollableScrollPhysics(),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            for (final alphabet in alphabetList)
                              Text(
                                alphabet,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: DefaultColors.black,
                                  fontSize: scale(10),
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          if (ref.watch(fxlistSelectedAlphabetProvider) != null)
            TweenAnimationBuilder<double>(
              duration: const Duration(milliseconds: 300),
              tween: Tween<double>(begin: 0, end: 1),
              curve: Curves.easeInOut,
              builder: (context, opacity, child) => Opacity(opacity: opacity, child: child),
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  padding: EdgeInsets.all(scale(24)),
                  decoration: BoxDecoration(
                    color: DefaultColors.black.withAlpha(150),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    ref.read(fxlistSelectedAlphabetProvider) ?? "",
                    style: TextStyle(
                      fontSize: scale(40),
                      fontWeight: FontWeight.bold,
                      color: DefaultColors.white,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  String getFlagFromModel(List<Flag> flags, String code) {
    final flag = flags.firstWhere(
          (f) => f.code.toUpperCase() == code.toUpperCase(),
      orElse: () => Flag(code: code, flag: '🏳️'),
    );
    return flag.flag;
  }

  Flag getFlagAndNameFromModel(List<Flag> flags, String code) {
    return flags.firstWhere(
          (f) => f.code.toUpperCase() == code.toUpperCase(),
      orElse: () => Flag(code: code, flag: '🏳️', name: code),
    );
  }

  String getRateForCode(WidgetRef ref, String code, {bool buy = false}) {
    final fxRatesState = ref.read(ratesNotifierProvider);

    return fxRatesState.maybeWhen(
      data: (rates) {
        final item = rates.firstWhere(
              (e) => e.isoCode == code,
          orElse: () => FxRates(
            isoCode: code,
            isoCodeNum: '',
            ttBuy: '',
            ttSell: '',
            curName: '',
            shortCurName: '',
          ),
        );
        return buy
            ? (double.tryParse(item.ttBuy) ?? 0).toStringAsFixed(4)
            : (double.tryParse(item.ttSell) ?? 0).toStringAsFixed(4);
      },
      orElse: () => "0.0000",
    );
  }
}
