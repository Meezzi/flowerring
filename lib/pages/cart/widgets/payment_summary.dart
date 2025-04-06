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
    final labelStyle = TextStyle(
      fontSize: 16,
      color: Colors.grey[700],
    );

    return Column();
  }

  Widget _priceRow(String label, int value, TextStyle style) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: style),
        Text(value.toString(), style: style),
      ],
    );
  }
}
