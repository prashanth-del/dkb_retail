import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class AnimatedBalance extends StatefulWidget {
  final double finalBalance;
  final String currency;

  const AnimatedBalance({
    super.key,
    required this.finalBalance,
    required this.currency,
  });

  @override
  State<AnimatedBalance> createState() => _AnimatedBalanceState();
}

class _AnimatedBalanceState extends State<AnimatedBalance> {
  late List<String> finalDigits;
  late List<int> currentDigits;
  bool isVisible = true;

  @override
  void initState() {
    super.initState();
    finalDigits = _formatFinal(widget.finalBalance).split('');

    // start with all zeros
    currentDigits = finalDigits.map((d) => 0).toList();

    _startRollingAnimation();
  }

  String _formatFinal(double value) {
    if (value % 1 == 0) {
      return value.toInt().toString();
    } else {
      return value.toStringAsFixed(2);
    }
  }

  Future<void> _startRollingAnimation() async {
    final random = Random();

    // launch all digits rolling together
    final tasks = <Future>[];

    for (int i = 0; i < finalDigits.length; i++) {
      if (finalDigits[i] == '.') continue;

      tasks.add(() async {
        int target = int.parse(finalDigits[i]);
        int cycles = 5 + i; // still can vary per digit

        for (int c = 0; c <= cycles; c++) {
          await Future.delayed(Duration(milliseconds: (200)));
          if (!mounted) return;

          setState(() {
            currentDigits[i] = c < cycles ? random.nextInt(10) : target;
          });
        }
      }());
    }

    // wait until all digits finish (optional)
    await Future.wait(tasks);
  }

  Widget _buildDigit(String original, int digit) {
    if (original == ".") {
      return const Text(
        ".",
        style: TextStyle(
          fontSize: 32,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      );
    }
    return DigitSlot(digit: digit);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Total Balance",
            style: TextStyle(fontSize: 14, color: Colors.white70),
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: List.generate(
                  finalDigits.length,
                  (i) => isVisible
                      ? _buildDigit(finalDigits[i], currentDigits[i])
                      : const SizedBox(
                          width: 20,
                          child: Text(
                            "•",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 32, color: Colors.white),
                          ),
                        ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                widget.currency,
                style: const TextStyle(fontSize: 32, color: Colors.white),
              ),
              const SizedBox(width: 4),
              IconButton(
                alignment: Alignment.center,
                onPressed: () {
                  setState(() {
                    isVisible = !isVisible;
                  });
                },
                icon: Icon(
                  isVisible
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: Colors.white,
                  size: 25,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DigitSlot extends StatelessWidget {
  final int digit;

  const DigitSlot({super.key, required this.digit});

  @override
  Widget build(BuildContext context) {
    final digitHeight = MediaQuery.of(context).size.height * 0.055;

    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.055,
      height: digitHeight,
      child: ClipRect(
        child: SingleChildScrollView(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOutCubic,
            transform: Matrix4.translationValues(0, -digit * digitHeight, 0),
            child: Column(
              children: List.generate(
                10,
                (i) => SizedBox(
                  height: digitHeight,
                  child: Center(
                    child: Text(
                      "$i",
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.aspectRatio * 80,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
