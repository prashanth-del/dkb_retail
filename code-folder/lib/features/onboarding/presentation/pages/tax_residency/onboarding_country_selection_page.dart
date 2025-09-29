import 'package:db_uicomponents/components.dart';
import 'package:db_uicomponents/styles.dart';
import 'package:flutter/material.dart';

class CountrySelectionBottomSheet extends StatefulWidget {
  final List<String> allCountries;
  final List<String> selectedCountries;
  final ValueChanged<List<String>> onSelectionChanged;
  final String? isCheckBoxNotShown;
  final String? bottomButtonNotShown;

  const CountrySelectionBottomSheet({
    Key? key,
    required this.allCountries,
    required this.selectedCountries,
    required this.onSelectionChanged,
    this.isCheckBoxNotShown,
    this.bottomButtonNotShown,

  }) : super(key: key);

  @override
  _CountrySelectionBottomSheetState createState() =>
      _CountrySelectionBottomSheetState();
}

class _CountrySelectionBottomSheetState
    extends State<CountrySelectionBottomSheet> {
  List<String> selectedCountries = [];
  String searchQuery = "";

  @override
  void initState() {
    super.initState();
    selectedCountries = widget.selectedCountries;
  }

  void toggleSelection(String country) {
    setState(() {
      if (selectedCountries.contains(country)) {
        selectedCountries.remove(country);
      } else {
        selectedCountries.add(country);
      }
    });
    widget.onSelectionChanged(selectedCountries);
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.7,
      maxChildSize: 0.9,
      minChildSize: 0.3,
      builder: (_, controller) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Select your Countries",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: DefaultColors.black,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.close, color: Colors.grey),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                SizedBox(height: 8.0),
                UiSearch(
                  borderColorOfSearch: DefaultColors.grayE6,
                ),
                // Search Bar
                // TextField(
                //   onChanged: (value) {
                //     setState(() {
                //       searchQuery = value;
                //     });
                //   },
                //   decoration: InputDecoration(
                //     prefixIcon: Icon(Icons.search, color: Colors.grey),
                //     hintText: 'Search for a country',
                //     filled: true,
                //     fillColor: Colors.grey[100],
                //     border: OutlineInputBorder(
                //       borderRadius: BorderRadius.circular(12.0),
                //       borderSide: BorderSide.none,
                //     ),
                //   ),
                // ),
                SizedBox(height: 16.0),
                // Country List
                Expanded(
                  child: ListView.builder(
                    controller: controller,
                    itemCount: widget.allCountries.length,
                    itemBuilder: (context, index) {
                      final country = widget.allCountries[index];
                      final isSelected = selectedCountries.contains(country);

                      // Filter countries based on search query
                      if (searchQuery.isNotEmpty &&
                          !country
                              .toLowerCase()
                              .contains(searchQuery.toLowerCase())) {
                        return SizedBox.shrink();
                      }

                      return GestureDetector(
                        onTap: () => toggleSelection(country),
                        child: Container(
                          // height: 50,
                          margin: const EdgeInsets.symmetric(vertical: 4.0),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 8.0),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? DefaultColors.blue9D.withOpacity(0.1)
                                : DefaultColors.grayE6.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              if(widget.isCheckBoxNotShown != "true")
                              Checkbox(
                                value: isSelected,
                                onChanged: (_) => toggleSelection(country),
                                activeColor: DefaultColors.blue9D,
                              ),

                              Expanded(
                                child: Text(
                                  country,
                                  maxLines: null,
                                  overflow: TextOverflow.visible,
                                  style: TextStyle(
                                    color: isSelected
                                        ? DefaultColors.blue9D
                                        : DefaultColors.black,
                                    fontWeight: isSelected
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 16.0),
                // Select Button
                if(widget.bottomButtonNotShown != "true")
                  ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: DefaultColors.blue9D,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  child: Text(
                    "SELECT",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
