import 'package:flowerring/model/product.dart';
import 'package:flowerring/pages/list/widgets/product_item.dart';
import 'package:flutter/material.dart';

class ListPage extends StatelessWidget {
  const ListPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Product.getProducts()로 상품 데이터 가져오기
    final List<Product> items = Product.getProducts(); // 상품 목록 가져오기
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('플라워링'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.shopping_cart_outlined),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          Product product = items[index];
          return ProductItem(product: product);
        },
      ),
    );
  }
}
