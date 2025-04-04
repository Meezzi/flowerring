import 'package:flutter/material.dart';
import 'package:flowerring/model/product.dart';

class ProductItem extends StatelessWidget {
  final Product product;

  const ProductItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border(bottom: BorderSide(color: Colors.grey[300]!)),
      ),
      alignment: Alignment.centerLeft,
      child: Text(product.title),
    );
  }
}
