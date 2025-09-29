import 'package:auto_route/annotations.dart';
import 'package:db_uicomponents/components.dart';
import 'package:dkb_retail/core/constants/colors.dart';
import 'package:flutter/Material.dart';

import '../../../../core/constants/app_strings/default_string.dart';
import '../../../../core/utils/ui_components/auto_leading_widget.dart';
import '../../../login/presentation/widgets/search_widget.dart';

@RoutePage(name: "FaqScreenRoute")
class FaqScreen extends StatefulWidget {
  const FaqScreen({super.key});
  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  final TextEditingController _searchController = TextEditingController();

  // Your FAQ data
  final List<Map<String, String>> _faqData = [
    {
      "title": "How do I open a savings account?",
      "description":
          "You can open a savings account by visiting our branch or applying online",
    },
    {
      "title": "What documents are required for KYC?",
      "description":
          "You will need a valid ID proof, address proof, and passport-size photograph",
    },
    {
      "title": "How can I reset my online banking password?",
      "description":
          "Go to the login page, click on ‘Forgot Password’ and follow the steps",
    },
    {
      "title": "Is there a minimum balance requirement?",
      "description":
          "Yes, maintaining a minimum balance depends on the type of account",
    },
    {
      "title": "How do I apply for a debit card?",
      "description":
          "You can apply for a debit card via internet banking or at your nearest branch",
    },
  ]; // todo fetch this from server later

  late List<Map<String, String>> _filteredFaqs;

  @override
  void initState() {
    super.initState();
    _filteredFaqs = _faqData; // initially show all
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredFaqs = _faqData.where((faq) {
        final title = faq["title"]!.toLowerCase();
        final desc = faq["description"]!.toLowerCase();
        return title.contains(query) || desc.contains(query);
      }).toList();
    });
  }

  int? _expandedIndex; // index of currently expanded FAQ

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DefaultColors.white,
      appBar: UIAppBar.secondary(
        title: '',
        autoLeadingWidget: LeadingWidget(
          title: DefaultString.instance.faqsTitle,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            //  UIFormTextField.underlined(hintText: hintText)
            // Search box
            SearchTextFilled(
              controller: _searchController,
              hintText: DefaultString.instance.searchForFaqTitle,
            ),
            const SizedBox(height: 24),

            // If no results, show "No Data" in the center
            Expanded(
              child: _filteredFaqs.isNotEmpty
                  ? ListView.separated(
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 6),
                      itemCount: _filteredFaqs.length,
                      itemBuilder: (context, index) {
                        final faq = _filteredFaqs[index];
                        return ItemWidget(
                          title: faq["title"]!,
                          description: faq["description"]!,
                          isExpanded: _expandedIndex == index,
                          onTap: () {
                            setState(() {
                              if (_expandedIndex == index) {
                                _expandedIndex =
                                    null; // collapse if tapping same FAQ
                              } else {
                                _expandedIndex = index; // expand new FAQ
                              }
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
            ),
          ],
        ),
      ),
    );
  }
}

class ItemWidget extends StatelessWidget {
  final String title;
  final String description;
  final bool isExpanded;
  final VoidCallback onTap;

  const ItemWidget({
    super.key,
    required this.title,
    required this.description,
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
                      title,
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
                description,
                color: DefaultColors.black,
                fontWeight: FontWeight.w400,
                fontSize: 11,
                maxLines: 2,
              ),
            ),
        ],
      ),
    );
  }
}
