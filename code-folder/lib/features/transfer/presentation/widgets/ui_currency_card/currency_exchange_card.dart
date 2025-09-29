import 'package:db_uicomponents/components.dart';
import 'package:flutter/material.dart';
import 'package:dkb_retail/core/constants/colors.dart';
import 'package:dkb_retail/features/transfer/data/model/flag_model.dart';

class CurrencyExchangeCard extends StatefulWidget {
  final String name;
  final String fromCurrency;
  final String toCurrency;
  final String fromFlag;
  final String toFlag;
  final double fromAmount;
  final double toAmount;
  final String? exchangeRate;

  const CurrencyExchangeCard({
    Key? key,
    required this.name,
    required this.fromCurrency,
    required this.toCurrency,
    required this.fromFlag,
    required this.toFlag,
    required this.fromAmount,
    required this.toAmount,
     this.exchangeRate,
  }) : super(key: key);

  @override
  State<CurrencyExchangeCard> createState() => _CurrencyExchangeCardState();
}

class _CurrencyExchangeCardState extends State<CurrencyExchangeCard> {
  List<Flag> flags = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
      _loadFlags();

  }
   Future<void> _loadFlags() async {
     try {
       flags = await Flag.loadFlags();
       if (mounted) {
         setState(() {
           isLoading = false;
         });
       }
     } catch (e) {
       if (mounted) {
         setState(() {
           isLoading = false;
         });
       }
       debugPrint("Failed to load flags: $e");
     }
   }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    Flag? flag = flags.firstWhere(
          (f) => f.code.toLowerCase() == widget.fromCurrency.toLowerCase(),
      orElse: () => Flag(flag: "qa.png", code: widget.fromCurrency),
    );

    Flag? flag2 = flags.firstWhere(
          (f) => f.code.toLowerCase() == widget.toCurrency.toLowerCase(),
      orElse: () => Flag(flag: "qa.png", code: widget.toCurrency),
    );


    return UiCard(
      // borderColor:DefaultColors.blue01,

      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            UiTextNew.custom(widget.name, fontSize: 18, fontWeight: FontWeight.bold),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildCurrencyInfo(widget.fromCurrency, flag.flag),
                Expanded(child: _buildDashedLineWithArrow()),
                _buildCurrencyInfo(widget.toCurrency, flag2.flag),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                UiTextNew.custom(
                  widget.fromAmount.toStringAsFixed(2),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                UiTextNew.custom(
                  widget.toAmount.toStringAsFixed(2),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),

              ],
            ),
            const SizedBox(height: 8),
            if (widget.exchangeRate != null) ...[
              const SizedBox(height: 8),
              UiTextNew.h4Medium(
                widget.exchangeRate!,
                color: DefaultColors.gray53,
              ),
            ],

          ],
        ),
      ),
    );
  }

  Widget _buildCurrencyInfo(String currency, String flagPath) {
    return Row(
      children: [
        CircleAvatar(
          radius: 12,
          backgroundColor: Colors.grey[300],
          child: ClipOval(
            child: Image.asset(
              'assets/images/flags/$flagPath',
              width: 20,
              height: 20,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(width: 6),
        UiTextNew.custom(currency, fontSize: 16, fontWeight: FontWeight.w500),
      ],
    );
  }

  Widget _buildDashedLineWithArrow() {
    return Stack(
      alignment: Alignment.center,
      children: [
        CustomPaint(
          painter: DashPainter(),
          child: SizedBox(height: 1, width: double.infinity),
        ),
        Icon(Icons.arrow_forward_ios, size: 12, color: Colors.grey),
      ],
    );
  }
}
class DashPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    const double dashWidth = 5;
    const double dashSpace = 3;
    double startX = 0;

    while (startX < size.width) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}