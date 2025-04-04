import 'package:flutter/material.dart';

class ListPage extends StatelessWidget {
  const ListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final item = [
      Product('assets/sample.jpg', '사과', 10000, 4.5),
      Product('assets/sample.jpg', '바나나', 10000, 4.5),
      Product('assets/sample.jpg', '오렌지', 10000, 4.5),
    ];
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
        itemCount: item.length,
        itemBuilder: (context, index) {
          Product product = item[index];
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
        },
      ),
    );
  }
}

//상품 클래스 생성
class Product {
  String imageUrl; //이미지 Ur
  String title; // 상품명
  int price; // 상품 가격
  double rate; // 상품 평점
  //상품 생성자
  Product(this.imageUrl, this.title, this.price, this.rate);
}
