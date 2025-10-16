import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../core/constants/app_strings/default_string.dart';
import 'main_card_widget.dart';

class IntroductionBody extends StatefulWidget {
  const IntroductionBody({super.key});

  @override
  State<IntroductionBody> createState() => _IntroductionBodyState();
}

class _IntroductionBodyState extends State<IntroductionBody>
    with SingleTickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController _controller;
  Timer? _timer; // keep reference to cancel later

  bool hide = false;
  bool secondHide = false;

  late LinearGradient color;

  bool _slideRight = false, _flyOut = false;

  bool _wrapped = false;
  bool _instantSlide = false;
  Offset _slideOffset = Offset.zero;

  late int selected;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );

    color = LinearGradient(
      colors: <Color>[
        const Color(0xFF9296FF).withValues(alpha: 0.1),
        const Color(0xFFB25BFF).withValues(alpha: 0.1),
      ],
    );

    selected = 0;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(Durations.medium4, () {
        if (!mounted) return;
        _controller.forward();

        Future.delayed(const Duration(seconds: 1, milliseconds: 900), () {
          if (!mounted) return;
          _controller.stop();
          setState(() => hide = true);

          Future.delayed(const Duration(milliseconds: 50), () {
            if (!mounted) return;
            _controller.forward();
          });
        });
      });
    });

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        if (!mounted) return;
        setState(() {
          secondHide = true;
          color = LinearGradient(
            colors: <Color>[
              const Color(0xFF4CAF50).withValues(alpha: 0.5),
              const Color(0xFF020A3C).withValues(alpha: 0.9),
            ],
          );
          _slideRight = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose(); // dispose ticker
    _timer?.cancel(); // cancel timer
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    _animation = Tween<double>(
      begin: -height * 0.2,
      end: height * 0.24,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    return Stack(
      children: [
        AnimatedBuilder(
          animation: _animation,
          builder: (context, child) => Positioned(
            top: _animation.value,
            left: width / 2 - (width * 0.435),
            child: Column(
              children: <Widget>[
                //second card
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 100),
                  opacity: secondHide ? 0 : 1,
                  child: Container(
                    width: 300,
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                        colors: <Color>[
                          const Color(0xFF01082C).withOpacity(0.9),
                          const Color(0xFF673AB7).withOpacity(0.2),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                //first card
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 100),
                  opacity: hide ? 0 : 1,
                  child: Container(
                    width: 300,
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                        colors: <Color>[
                          const Color(0xFF4CAF50).withValues(alpha: 0.5),
                          const Color(0xFF020A3C).withValues(alpha: 0.9),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // --- Sliding Main Card ---
        Column(
          children: [
            SizedBox(height: height * 0.25),
            Dismissible(
              key: UniqueKey(), // A unique key for each item is crucial
              direction: DismissDirection.horizontal,
              onDismissed: (direction) {
                if (direction == DismissDirection.endToStart) //left swipe
                {
                  if (selected != 0) {
                    setState(() {
                      selected--;
                    });
                  }
                }
                if (direction == DismissDirection.startToEnd) //right swipe
                {
                  if (selected != 1) {
                    setState(() {
                      selected++;
                    });
                  }
                }
              },
              child: AnimatedAlign(
                duration: const Duration(milliseconds: 500),
                curve: Curves.ease,
                alignment: _slideRight
                    ? Alignment.topCenter
                    : Alignment.topCenter,
                onEnd: () {
                  if (_slideRight && !_flyOut && !_wrapped) {
                    setState(() {
                      _flyOut = true;
                      _slideOffset = const Offset(2.2, 0);
                    });
                  }
                },
                child: AnimatedSlide(
                  duration: _instantSlide
                      ? Duration.zero
                      : const Duration(milliseconds: 600),
                  curve: Curves.easeInOut,
                  offset: _slideOffset,
                  onEnd: () {
                    if (_flyOut && !_wrapped) {
                      setState(() {
                        _instantSlide = true;
                        _slideOffset = const Offset(-2.2, 0);
                        _flyOut = false;
                        _wrapped = true;
                      });

                      Future.delayed(const Duration(seconds: 1), () {
                        if (!mounted) return;
                        setState(() {
                          _instantSlide = false;
                          _slideOffset = Offset.zero;
                          _slideRight = false;
                        });
                      });
                    }
                  },
                  child: buildMainCard(animation: _animation, color: color),
                ),
              ),
            ),
            SizedBox(height: height * 0.05),
            // --- Indicator ---
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                2,
                (index) => GestureDetector(
                  onTap: () {
                    setState(() {
                      selected = index;
                    });
                  },
                  child: AnimatedContainer(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    duration: const Duration(milliseconds: 250),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: index == selected ? 80 : 20,
                    height: 4,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: index == selected
                          ? Colors.white
                          : Colors.white.withOpacity(0.5),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: height * 0.05),
            // --- Title + Subtitle ---
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  child: Text(
                    DefaultString.instance.walletCarouselTitles[selected],
                    key: ValueKey<int>(selected),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      height: 1.3,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 12),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  child: Text(
                    DefaultString.instance.walletCarouselSubtitles[selected],
                    key: ValueKey<int>(selected),
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                      height: 1.4,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            SizedBox(height: height * 0.05),
          ],
        ),
      ],
    );
  }
}
