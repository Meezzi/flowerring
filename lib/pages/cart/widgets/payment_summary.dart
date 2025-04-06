import 'package:flutter/material.dart';

class PaymentSummary extends StatelessWidget {
  final int productPrice;
  final int deliveryFee;

  const PaymentSummary({
    super.key,
    required this.productPrice,
    required this.deliveryFee,
  });

  @override
  Widget build(BuildContext context) {
    return Column();
  }
}
