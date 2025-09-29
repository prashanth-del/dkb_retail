import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:flutter/material.dart';

class MultiSelectBottomSheet extends StatefulWidget {
  final List<String> items;
  final Set<String> initialSelectedItems;
  final ValueChanged<Set<String>> onSelected;

  const MultiSelectBottomSheet({
    Key? key,
    required this.items,
    required this.initialSelectedItems,
    required this.onSelected,
  }) : super(key: key);

  @override
  _MultiSelectBottomSheetState createState() => _MultiSelectBottomSheetState();
}

class _MultiSelectBottomSheetState extends State<MultiSelectBottomSheet> {
  late Set<String> selectedItems;

  @override
  void initState() {
    super.initState();
    // Initialize with the provided selected items
    selectedItems = Set<String>.from(widget.initialSelectedItems);
  }

  void _toggleSelection(String item) {
    setState(() {
      if (item == "All") {
        selectedItems = {"All"}; // Clear all and select "All"
      } else {
        selectedItems.contains(item)
            ? selectedItems.remove(item) // Toggle individual item
            : selectedItems.add(item);
        selectedItems.remove("All"); // Deselect "All" if any item is selected
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                const Expanded(
                  child: Text(
                    'Select Items',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.items.length,
              itemBuilder: (context, index) {
                final item = widget.items[index];
                final isSelected = selectedItems.contains(item);
                return ListTile(
                  title: Text(item),
                  trailing: Icon(
                    isSelected
                        ? Icons.check_box
                        : Icons.check_box_outline_blank,
                    color: isSelected ? DefaultColors.primaryBlue : null,
                  ),
                  onTap: () => _toggleSelection(item),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: UIButton.rounded(onPressed: () {
              Navigator.pop(context, selectedItems);
              widget.onSelected(Set<String>.from(selectedItems));
            }, label: 'Apply', maxWidth: context.screenWidth,height: 40,),
          ),
          // Padding(
          //   padding: const EdgeInsets.all(16.0),
          //   child: SizedBox(
          //     width: double.maxFinite,
          //     height: 40,
          //     child: ElevatedButton(
          //       style: ElevatedButton.styleFrom(
          //         backgroundColor: DefaultColors
          //             .primaryBlue, // Replace with your desired blue color
          //         padding: const EdgeInsets.symmetric(vertical: 14.0),
          //         shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(8.0),
          //         ),
          //       ),
          //       onPressed: () {
          //         // Return the final selected items and close the sheet
          //         Navigator.pop(context, selectedItems);
          //         widget.onSelected(Set<String>.from(selectedItems));
          //       },
          //       child: UiTextNew.h3Semibold('Apply', color: DefaultColors.white,),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
