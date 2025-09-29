import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../../core/router/app_router.dart';
import '../widgets/db_button.dart';
import '../widgets/db_list.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen>
    with SingleTickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController _controller;

  bool hide = false;
  bool secondHide = false;

  late LinearGradient color;
  late double newOpacity;

  bool _slideRight = false, _flyOut = false;

  bool _wrapped = false;
  bool _instantSlide = false;
  Offset _slideOffset = Offset.zero;

  late int selected;

  @override
  void initState() {
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
    ;
    newOpacity = 0.5;
    selected = 0;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(Durations.medium4, () {
        _controller.forward();

        Future.delayed(const Duration(seconds: 2), () {
          _controller.stop();
          setState(() {
            hide = true;
          });

          Future.delayed(const Duration(milliseconds: 50), () {
            _controller.forward();
          });
        });
      });
    });

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
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

    Timer.periodic(const Duration(seconds: 4, milliseconds: 700), (_) {
      setState(() {
        selected = (selected + 1) % 3;
      });
    });

    super.initState();
  }

  Widget buildMainCard() {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            width: 300,
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: color,
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // --- Top Row ---
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Row(
                        children: [
                          Icon(
                            Icons.account_balance,
                            size: 18,
                            color: Colors.white,
                          ),
                          SizedBox(width: 8),
                          Text(
                            "DUKHAN BANK",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "VISA",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  // --- Chip + NFC ---
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 50,
                        height: 35,
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      const Icon(Icons.wifi, color: Colors.white, size: 28),
                    ],
                  ),

                  // --- Card Number ---
                  const Text(
                    "1234 5678 9009 8765",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      letterSpacing: 3,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  // --- Name + Expiry ---
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        "MOHAMMED ALI",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "08/28",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    _animation = Tween<double>(
      begin: height / 2 - 100 - 400 - 48,
      end: height / 2 - 100,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF02269C), Color(0xFFBBF4CA), Color(0xFF031A39)],
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // --- Animated Card Backgrounds ---
            AnimatedBuilder(
              animation: _animation,
              builder: (context, child) => Positioned(
                top: _animation.value,
                left: width / 2 - 150,
                child: Column(
                  children: <Widget>[
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
            AnimatedAlign(
              duration: const Duration(milliseconds: 500),
              curve: Curves.ease,
              alignment: _slideRight ? Alignment.centerRight : Alignment.center,
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
                child: buildMainCard(),
              ),
            ),

            // --- Indicator ---
            Positioned(
              bottom: height * 0.35,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  3,
                  (index) => AnimatedContainer(
                    padding: EdgeInsets.symmetric(vertical: 20),
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

            // --- Title + Subtitle ---
            Positioned(
              bottom: height * 0.15,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    child: Text(
                      DbList.walletCarouselItems[selected]["title"]!,
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
                      DbList.walletCarouselItems[selected]["subtitle"]!,
                      key: ValueKey<String>(
                        DbList.walletCarouselItems[selected]["subtitle"]!,
                      ),
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
            ),

            // --- Buttons ---
            Positioned(
              bottom: 40,
              left: 16,
              right: 16,
              child: Row(
                children: [
                  Expanded(
                    child: DbButton(
                      title: "Create Account",
                      onTap: () {},
                      isOutlinedButton: true,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: DbButton(
                      title: "Login",
                      onTap: () {
                        context.router.replace(LoginRoute());
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
