part of '../ui_bottom_sheet.dart';

class UiSortBottomSheet extends StatefulWidget {
  final BuildContext context;
  final List<String> items;
  final String? title;
  final String confirmButtonTitle;
  final int initialSelectedIndex; // selectedIndex from your provider
  final ValueChanged<int> onItemSelected;
  final String? selectedValue;
  final String backIconPath;

  UiSortBottomSheet({
    required this.context,
    required this.items,
    this.title,
    this.selectedValue,
    this.backIconPath = "assets/svg/Right.svg",
    required this.confirmButtonTitle,
    required this.onItemSelected,
    this.initialSelectedIndex = 0, // Default to 0 if not provided
  });

  @override
  _UiSortBottomSheetState createState() => _UiSortBottomSheetState();
}

class _UiSortBottomSheetState extends State<UiSortBottomSheet> {
  late int selectedOption;

  @override
  void initState() {
    super.initState();

    // Initialize selectedOption with the passed initialSelectedIndex
    if (widget.selectedValue != null) {
      selectedOption = widget.items.indexOf(widget.selectedValue!);
    } else {
      selectedOption =
          widget.initialSelectedIndex; // Ensure initialSelectedIndex is set
    }
  }

  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: CustomScrollView(
              controller: scrollController,
              shrinkWrap: true,
              slivers: [
                _buildHeader(),
                _buildItemList(),
              ],
            ),
          ),
          _buildFooter(),
        ],
      ),
    );
  }

  SliverPersistentHeader _buildHeader() {
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    UISvgIcon(
                      assetPath: widget.backIconPath,
                      onTap: () => Navigator.pop(context),
                    ).toDirectional(context),
                    UiSpace.horizontal(8),
                    UiTextNew.b1Semibold(widget.title ?? "Sort By"),
                    const Spacer(),
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(
                        Icons.close,
                        color: DefaultColors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Divider(
              color: DefaultColors.blue_02,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItemList() {
    return SliverList.separated(
      itemCount: widget.items.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        bool isSelected = selectedOption == index;
        return UiCard(
          onTap: () {
            setState(() {
              selectedOption = index; // Update selectedOption on tap
            });
          },
          cardColor: isSelected
              ? DefaultColors.blue_200.withOpacity(0.3)
              : DefaultColors.white,
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
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
                        ? UiTextNew.b1Semibold(widget.items[index],
                            color: DefaultColors.blue_600)
                        : UiTextNew.b1Regular(widget.items[index],
                            color: DefaultColors.black),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFooter() {
    return Container(
      child: UIButton.primary(
        height: 40,
        maxWidth: double.infinity,
        label: widget.confirmButtonTitle,
        isRoundedButton: true,
        onPressed: () {
          // Call the onItemSelected callback with the selected option
          Navigator.pop(context);
          widget.onItemSelected(selectedOption);
        },
      ),
    );
  }
}
