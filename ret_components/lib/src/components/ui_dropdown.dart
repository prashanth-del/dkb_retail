import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:flutter/material.dart';

import '../../components.dart';

class UiDropdownValue {
  final String? value;
  final String labelText;
  final VoidCallback? onTap;

  UiDropdownValue({
    required this.value,
    required this.labelText,
    this.onTap,
  });
}

class UiDropdown extends StatefulWidget {
  final String? labelText;
  final List<UiDropdownValue>? items;
  final EdgeInsets? margin;
  final double? height;
  final bool isLoading;
  final bool hasError;
  final VoidCallback? onTapReload;
  final String? hintText;
  final String? selectedValue;
  final Function(String?)? onChanged;

  const UiDropdown({
    this.labelText,
    this.items,
    this.margin,
    this.height,
    this.isLoading = false,
    this.hasError = false,
    this.hintText,
    this.onTapReload,
    required this.selectedValue,
    required this.onChanged,
    super.key,
  })  : assert(
          isLoading != true || hasError != true,
          'Either isLoading or hasError must be false',
        ),
        assert(
          (hasError == true && onTapReload != null) || (hasError == false),
          'If hasError is true, assign an onTapReload function',
        );

  @override
  State<UiDropdown> createState() => _UiDropdownState();
}

class _UiDropdownState extends State<UiDropdown> {
  // String? selectedItem;
  //
  // @override
  // void didUpdateWidget(covariant UiDropdown oldWidget) {
  //   super.didUpdateWidget(oldWidget);
  //
  //   if (widget.items != oldWidget.items) {
  //     setState(() {
  //       selectedItem = null;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: context.screenWidth),
      margin: widget.margin ?? const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (widget.labelText != null) ...[
            Text(
              widget.labelText!,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: Color(0xFF828282),
              ),
            ),
            const UiSpace.vertical(4),
          ],
          SizedBox(
            height: widget.height ?? 40,
            child: Row(
              children: [
                Expanded(
                  child: FormField(builder: (state) {
                    return InputDecorator(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: DefaultColors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide(
                            color: const Color(0xFF00539D).withOpacity(0.2),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide(
                            color: const Color(0xFF00539D).withOpacity(0.2),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide(
                            color: const Color(0xFF00539D).withOpacity(0.2),
                          ),
                        ),
                        isDense: true,
                      ),
                      child: DropdownButtonHideUnderline(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 0, right: 8),
                          child: DropdownButton(
                            borderRadius: BorderRadius.circular(8),
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF2F2D2D),
                            ),
                            hint: widget.hintText != null
                                ? Text(
                                    '${widget.hintText}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13,
                                      color: Color(0xFF898989),
                                    ),
                                  )
                                : null,
                            value: widget.selectedValue,
                            items: widget.items?.map((item) {
                              return DropdownMenuItem(
                                value: item.value,
                                onTap: item.onTap,
                                child: Text(
                                  item.labelText,
                                  style: const TextStyle(
                                    color: Color(0xFF2F2D2D),
                                  ),
                                ),
                              );
                            }).toList(),
                            isExpanded: false,
                            underline: const SizedBox.shrink(),
                            onChanged: widget.onChanged,
                            icon: const Icon(
                              Icons.keyboard_arrow_down,
                              color: Color(0xFF00529B),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
                if (widget.isLoading)
                  const SizedBox(
                    width: 40,
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.all(12.0),
                        child: CircularProgressIndicator(
                          strokeWidth: 3,
                        ),
                      ),
                    ),
                  ),
                if (widget.hasError)
                  SizedBox(
                    width: 40,
                    child: Center(
                      child: IconButton(
                        visualDensity: VisualDensity.compact,
                        icon: const Icon(Icons.refresh),
                        onPressed: () {
                          if (widget.onTapReload != null) {
                            widget.onTapReload!();
                          }
                        },
                      ),
                    ),
                  )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
