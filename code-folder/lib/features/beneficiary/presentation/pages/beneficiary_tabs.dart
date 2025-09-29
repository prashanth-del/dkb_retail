import 'package:db_uicomponents/components.dart';
import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:dkb_retail/core/utils/extensions/locale_extension.dart';
import 'package:dkb_retail/features/beneficiary/presentation/controller/beneficiary_provider.dart';
import 'package:dkb_retail/features/beneficiary/presentation/widgets/tabPages/view_approved_page.dart';
import 'package:dkb_retail/features/beneficiary/presentation/widgets/tabPages/view_pending_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BeneficiaryTabs extends ConsumerStatefulWidget {
  const BeneficiaryTabs({super.key});

  @override
  ConsumerState<BeneficiaryTabs> createState() => _BeneficiaryTabsState();
}

class _BeneficiaryTabsState extends ConsumerState<BeneficiaryTabs>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selectedIndex = ref.watch(activeTabIndex);

    ref.listen<int>(activeTabIndex, (prev, next) {
      if (mounted && _tabController.index != next) {
        _tabController.animateTo(next);
      }
    });

    return _buildTabs(selectedIndex);
  }

  _buildTabs(int selectedIndex) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(10, 5, 10, 2),
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
            decoration: BoxDecoration(
              color: DefaultColors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: TabBar(
              indicatorWeight: 0,
              tabAlignment: TabAlignment.fill,
              controller: _tabController,
              dividerColor: DefaultColors.transparent,
              indicator: BoxDecoration(
                color: DefaultColors.blue60,
                borderRadius: BorderRadius.circular(8),
              ),
              indicatorSize: TabBarIndicatorSize.tab,
              tabs: ['Approved', 'Pending']
                  .map(
                    (title) => SizedBox(
                      width: (context.screenWidth / 2) - 20,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 2,
                          vertical: 8,
                        ),
                        child: Center(
                          child: UiTextNew.b2Semibold(
                            title,
                            textAlign: TextAlign.center,
                            color:
                                selectedIndex ==
                                    ['Approved', 'Pending'].indexOf(title)
                                ? DefaultColors.white
                                : DefaultColors.gray2D,
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
              onTap: (index) {
                ref.read(activeTabIndex.notifier).state = index;
                setState(() {});
              },
            ),
          ),
          Flexible(
            child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _tabController,
              children: [
                ViewApprovedPage(),
                ViewPendingPage(),
                // Container(child: Center(child: Text('Approved Content'))),
                // Container(child: Center(child: Text('Pending Content'))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
