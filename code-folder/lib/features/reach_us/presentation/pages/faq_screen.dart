import 'package:async_ui/async_ui.dart';
import 'package:auto_route/annotations.dart';
import 'package:db_uicomponents/components.dart';
import 'package:dkb_retail/core/constants/colors.dart';
import 'package:dkb_retail/features/reach_us/data/models/fetch_faq_request.dart';
import 'package:dkb_retail/features/reach_us/presentation/state/fetch_faq_state.dart';
import 'package:flutter/Material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_strings/default_string.dart';
import '../../../common/presentation/components/auth_header_wrapper.dart';
import '../../../login/presentation/widgets/search_widget.dart';
import '../../domain/entities/faqs_faq_list_item.dart';
import '../controller/fetch_faq_notifier.dart';
import '../widgets/empty_widget.dart';

@RoutePage(name: "FaqScreenRoute")
class FaqScreen extends ConsumerStatefulWidget {
  const FaqScreen({super.key});
  @override
  ConsumerState<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends ConsumerState<FaqScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      // todo add this for new structrure
      ref
          .read(fetchFaqNotifierProvider.notifier)
          .fetchFaq(request: FetchFaqRequest(/* add required params */));
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //  final asyncState = ref.watch(faqNotifierProvider);

    return Scaffold(
      backgroundColor: DefaultColors.white,
      body: AuthHeaderWrapper(
        headerText: DefaultString.instance.faqsTitle,
        child: RxView<FetchFaqState, List<FaqsFaqListItem>>(
          stateProvider: fetchFaqNotifierProvider,
          map: (FetchFaqState state) {
            return state.when(
              initial: () => const AsyncValue.data([]),
              loading: () => const AsyncValue.loading(),
              success: (value) => AsyncValue.data(value!.faqList),
              failure: (error) => AsyncValue.error(error, StackTrace.current),
            );
          },
          data: (BuildContext context, List<FaqsFaqListItem> data) {
            return data.isNotEmpty
                ? FaqWidget(faqListItem: data)
                : const Center(child: Text('No Data Available'));
          },
          // loading: (context) =>
          //     const Center(child: CircularProgressIndicator()),
          error: (context, error, stack) => ErrorCommonWidget(
            error: error.toString(),
            onPressed: () {
              ref
                  .read(fetchFaqNotifierProvider.notifier)
                  .fetchFaq(request: FetchFaqRequest());
            },
          ),
          //     Center(
          //   child: ConstrainedBox(
          //     constraints: BoxConstraints(
          //       minHeight: MediaQuery.of(
          //         context,
          //       ).size.height, // full screen height
          //     ),
          //     child: Column(
          //       mainAxisSize: MainAxisSize.min, // content size
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       crossAxisAlignment: CrossAxisAlignment.center,
          //       children: [
          //         UiTextNew.customRubik(
          //           error.toString(),
          //           fontSize: 14,
          //           textAlign: TextAlign.center,
          //           overflow: TextOverflow.ellipsis,
          //
          //           maxLines: 3,
          //         ),
          //         const SizedBox(height: 16),
          //         ElevatedButton(
          //           onPressed: () => ref
          //               .read(fetchFaqNotifierProvider.notifier)
          //               .fetchFaq(request: FetchFaqRequest()),
          //           child: const UiTextNew.customRubik(
          //             "Retry",
          //             fontSize: 15,
          //             color: DefaultColors.blue,
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
        ),
      ),

      // AuthHeaderWrapper(
      //   headerText: DefaultString.instance.faqsTitle,
      //   child: RxView<FetchFaqState, List<FaqsFaqListItem>>(
      //     stateProvider: fetchFaqNotifierProvider,
      //     map: (FetchFaqState state) {
      //       return state.when(
      //         initial: () {
      //           return AsyncValue.data([]);
      //         },
      //         loading: () {
      //           return AsyncValue.loading();
      //         },
      //         success: (value) {
      //           return AsyncValue.data(value!.faqList);
      //         },
      //         failure: (error) {
      //           return AsyncValue.error(error, StackTrace.current);
      //         },
      //       );
      //     },
      //     data: (BuildContext context, List<FaqsFaqListItem> data) {
      //       return data.isNotEmpty
      //           ? FaqWidget(faqListItem: data)
      //           : Center(child: Text('No Data Available')); //EmptyWidget
      //     },
      //   ),
      // ),
    );
  }
}

class FaqWidget extends StatefulWidget {
  final List<FaqsFaqListItem> faqListItem;
  const FaqWidget({super.key, required this.faqListItem});

  @override
  _FaqWidgetState createState() => _FaqWidgetState();
}

class _FaqWidgetState extends State<FaqWidget> {
  final TextEditingController _searchController = TextEditingController();
  List<FaqsFaqListItem> _filteredFaqs = [];
  int? _expandedIndex;

  @override
  void initState() {
    super.initState();
    _filteredFaqs = widget.faqListItem;
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredFaqs = widget.faqListItem.where((faq) {
        final question = faq.question?.toLowerCase() ?? "";
        final answer = faq.answer?.toLowerCase() ?? "";
        return question.contains(query) || answer.contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 32),
          SearchTextFilled(
            controller: _searchController,
            hintText: DefaultString.instance.searchForFaqTitle,
          ),
          const SizedBox(height: 24),
          _filteredFaqs.isNotEmpty
              ? ListView.separated(
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 6),
                  itemCount: _filteredFaqs.length,
                  itemBuilder: (context, index) {
                    final faq = _filteredFaqs[index];
                    return ItemWidget(
                      question: faq.question ?? "",
                      answer: faq.answer ?? "",
                      isExpanded: _expandedIndex == index,
                      onTap: () {
                        setState(() {
                          _expandedIndex = _expandedIndex == index
                              ? null
                              : index;
                        });
                      },
                    );
                  },
                )
              : Center(
                  child: UiTextNew.customRubik(
                    DefaultString.instance.noResultSearch,
                    fontSize: 14,
                    color: DefaultColors.black,
                  ),
                ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}

class ItemWidget extends StatelessWidget {
  final String question;
  final String answer;
  final bool isExpanded;
  final VoidCallback onTap;

  const ItemWidget({
    super.key,
    required this.question,
    required this.answer,
    required this.isExpanded,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: DefaultColors.grayLightBase,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: UiTextNew.custom(
                      question,
                      color: DefaultColors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      maxLines: 2,
                    ),
                  ),
                  Icon(
                    isExpanded
                        ? Icons.keyboard_arrow_up_sharp
                        : Icons.keyboard_arrow_down_sharp,
                    color: DefaultColors.black,
                  ),
                ],
              ),
            ),
          ),
          if (isExpanded)
            Padding(
              padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
              child: UiTextNew.custom(
                answer,
                color: DefaultColors.black,
                fontWeight: FontWeight.w400,
                fontSize: 11,
                maxLines: 4,
              ),
            ),
        ],
      ),
    );
  }
}
