import 'dart:async';
import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:dkb_retail/core/utils/extensions/locale_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ResendOtpTimer extends ConsumerStatefulWidget {
  final void Function()? onResend;
  final bool isPaused;

  const ResendOtpTimer({super.key, this.onResend, this.isPaused = false});

  @override
  ConsumerState<ResendOtpTimer> createState() => _ResendOtpTimerState();
}

class _ResendOtpTimerState extends ConsumerState<ResendOtpTimer> {
  late Timer _timer;
  int _start = 179; // 2 minutes and 59 seconds in total seconds
  bool _timerStopped = false;

  @override
  void initState() {
    super.initState();
    if (!widget.isPaused) {
      startTimer();
    }
  }

  void startTimer() {
    _start = 179; // Reset timer to initial value
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (Timer timer) {
      if (_start == 0) {
        setState(() {
          _timerStopped = true;
          timer.cancel();
        });
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  String getFormattedTime() {
    int minutes = _start ~/ 60;
    int seconds = _start % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isPaused && !_timerStopped) {
      _timer.cancel();
      _timerStopped = true;
    }

    bool isBlurred = widget.isPaused || !_timerStopped;

    return Column(
      children: [
        UiTextNew.customRubik(
          getFormattedTime(),
          fontSize: 16,
          color: DefaultColors.orange14,
        ),
        const UiSpace.vertical(15),
        GestureDetector(
          onTap: _timerStopped
              ? widget.isPaused
                    ? null
                    : () {
                        if (widget.onResend != null) widget.onResend!();
                        setState(() {
                          _timerStopped = false;
                        });
                        startTimer(); // Restart the timer when "Resend OTP" is clicked
                      }
              : null,
          child: UiTextNew.customRubik(
            "Resend OTP",
            fontSize: 14,
            color: isBlurred
                ? DefaultColors.gray8A.withOpacity(0.5)
                : DefaultColors.gray8A,
          ),
        ),
      ],
    );
  }
}
