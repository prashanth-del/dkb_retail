
part of '../ui_bottom_sheet.dart';

class UiLocationBottomSheet extends StatelessWidget {
  final BuildContext context;
  final List<String> items;
  final String? title;
  final String confirmButtonTitle;
  final int? initialSelectedIndex;
  final ValueChanged<int> onItemSelected;

  const UiLocationBottomSheet({super.key,
    required this.context,
    required this.items,
    this.title,
    required this.confirmButtonTitle,
    required this.onItemSelected,
    this.initialSelectedIndex = 0,
  });

  @override
  Widget build(BuildContext context) {
    int? selectedOption = initialSelectedIndex;
    final scrollController = ScrollController();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Expanded(
            child: CustomScrollView(
              controller: scrollController,
              shrinkWrap: true,
              slivers: [
                _buildHeader(),
                _buildItemList(selectedOption, (index) {
                  selectedOption = index;
                }),
            
              ],
            ),
          ),
          
        ],
      ),
    );
  }

  SliverPersistentHeader _buildHeader() {
    final viewSize = MediaQuery.sizeOf(context);

    return SliverPersistentHeader(
      pinned: true,
      delegate: _BottomSheetPersistentHeader(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 32, bottom: 4),
              child: SizedBox(
                height: 24,
                child: Row(
                  children: [
                    UiTextNew.b1Semibold(title ?? "Sort By"),
                    const Spacer(),
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(
                        Icons.close,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Divider(
              color: DefaultColors.blue_02,
              indent: viewSize.width * 0.05,
              endIndent: viewSize.width * 0.05,
            ),
          ],
        ),
      ),
    );
  }

  StatefulBuilder _buildItemList(int? selectedOption, ValueChanged<int> onItemTap) {
    return StatefulBuilder(
      builder: (context, setState) {
        return SliverList.separated(
          itemCount: items.length,
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            bool isSelected = selectedOption == index;
            return UiCard(

              onTap: () {
                setState(() {
                  selectedOption = index;
                  onItemTap(index);
                });
                onItemSelected(index);
                Navigator.pop(context);
              },
              cardColor: isSelected
                  ? DefaultColors.blue_200.withOpacity(0.3)
                  : DefaultColors.white,
              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
              child: Row(
                children: [
                  if (isSelected)
                    const UIIconButton(
                      icon: Icons.check,
                      iconColor: DefaultColors.blue_600,
                    ),
                  const UiSpace.horizontal(15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        isSelected
                            ? UiTextNew.b1Semibold(items[index], color: DefaultColors.blue_600)
                            : UiTextNew.b1Semibold(items[index], color: DefaultColors.white_700),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
