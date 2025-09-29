import 'package:flutter/material.dart';

class UIKeypad extends StatelessWidget {
  final TextEditingController textEditingController;
  final int limitKeyLength;

  const UIKeypad({
    super.key,
    required this.textEditingController,
    required this.limitKeyLength,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 25),
      color: const Color(0xFFCDD2E0),
      child: GridView.count(
        crossAxisCount: 3,
        shrinkWrap: true,
        childAspectRatio: 2.1,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
        children: [
          ...List<Widget>.generate(
            9,
            (index) => _NumberButton(
              number: index + 1,
              letters: _getLettersForNumber(index + 1),
              onTap: (value) {
                addText(
                  controller: textEditingController,
                  value: value.toString(),
                );
              },
            ),
          ),
          const SizedBox(),
          _NumberButton(
            number: 0,
            letters: "",
            onTap: (value) {
              addText(
                controller: textEditingController,
                value: value.toString(),
              );
            },
          ),
          _IconButton(
            icon: Icons.backspace_outlined,
            onTap: () {
              removeLastString(controller: textEditingController);
            },
          ),
        ],
      ),
    );
  }

  void removeLastString({
    required TextEditingController controller,
  }) {
    final text = textEditingController.text;
    final selection = textEditingController.selection;
    if (selection.isCollapsed) {
      if (selection.start == 0) return;

      final newText = text.replaceRange(
        selection.start - 1,
        selection.start,
        '',
      );
      textEditingController.value = TextEditingValue(
        text: newText,
        selection: TextSelection.collapsed(
          offset: selection.start - 1,
        ),
      );
    } else {
      final newText = text.replaceRange(
        selection.start,
        selection.end,
        '',
      );
      textEditingController.value = TextEditingValue(
        text: newText,
        selection: TextSelection.collapsed(
          offset: selection.start,
        ),
      );
    }
  }

  void addText({
    required TextEditingController controller,
    required String value,
  }) {
    if (controller.text.length >= limitKeyLength) return;
    final newText = controller.text + value;

    controller.value = TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(
        offset: newText.length,
      ),
    );
  }

  String _getLettersForNumber(int number) {
    switch (number) {
      case 2:
        return "ABC";
      case 3:
        return "DEF";
      case 4:
        return "GHI";
      case 5:
        return "JKL";
      case 6:
        return "MNO";
      case 7:
        return "PQRS";
      case 8:
        return "TUV";
      case 9:
        return "WXYZ";
      default:
        return "";
    }
  }
}

class _NumberButton extends StatelessWidget {
  final int number;
  final String letters;
  final ValueChanged<int> onTap;

  const _NumberButton({
    required this.number,
    required this.letters,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
            8.0), // Change this value to adjust the border radius
      ),
      color: Colors.white,
      child: InkWell(
        onTap: () => onTap(number),
        borderRadius: BorderRadius.circular(5.0),
        splashFactory: InkRipple.splashFactory,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Transform.translate(
                offset: const Offset(0,
                    -2), // Adjust the offset to move the number closer to the letters
                child: Text(
                  '$number',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              if (letters.isNotEmpty)
                Transform.translate(
                  offset: const Offset(0,
                      -8), // Adjust the offset to move the letters closer to the number
                  child: Text(
                    letters,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _IconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _IconButton({
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.0),
      splashFactory: InkRipple.splashFactory,
      child: Center(
        child: Icon(
          icon,
          size: 24,
          color: Colors.black87,
        ),
      ),
    );
  }
}
