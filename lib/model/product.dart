import 'package:flutter/material.dart';

class Product {
  final String imageUrl;
  final String title;
  final int price;
  final double rate;

  // 생성자
  Product({
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.rate,
  });

  // 상품 데이터를 반환하는 메소드
  static List<Product> getProducts() {
    return [
      Product(
        imageUrl: 'assets/sample.jpg',
        title: '사과',
        price: 10000,
        rate: 4.5,
      ),
      Product(
        imageUrl: 'assets/sample.jpg',
        title: '바나나',
        price: 10000,
        rate: 4.5,
      ),
      Product(
        imageUrl: 'assets/sample.jpg',
        title: '오렌지',
        price: 10000,
        rate: 4.5,
      ),
    ];
  }
}
