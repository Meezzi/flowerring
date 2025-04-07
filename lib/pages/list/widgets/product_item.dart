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
      height: 80,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(15),
        border: Border(bottom: BorderSide(color: Colors.grey[300]!)),
      ),
      child: Row(
        children: [
          ClipRect(
            child: AspectRatio(
              aspectRatio: 1, // 1:1 비율로 설정
              child: Image.network(product.imageUrl, fit: BoxFit.cover),
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
    );
  }
}
