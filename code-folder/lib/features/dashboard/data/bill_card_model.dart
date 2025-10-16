import 'package:flutter/material.dart';

class BillCardModel {
  final String imageUrl;
  final String title;
  final String amount;
  final IconData trialIcon;

  BillCardModel({
    required this.imageUrl,
    required this.title,
    required this.amount,
    required this.trialIcon,
  });
}
