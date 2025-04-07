import 'package:flowerring/utils/format_price.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
    final total = productPrice + deliveryFee;

    final labelStyle = TextStyle(fontSize: 16, color: Colors.grey[700]);

    final totalLabelStyle = TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.grey[900],
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _priceRow('총 상품 가격', productPrice, labelStyle),
        SizedBox(height: 4),
        _priceRow('배송비', deliveryFee, labelStyle),
        SizedBox(height: 8),
        _priceRow('총 결제금액', total, totalLabelStyle),
      ],
    );
  }

  Widget _priceRow(
    String label,
    int value,
    TextStyle style,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: style),
        Text('${formatPrice(value)}원', style: style),
      ],
    );
  }
}
