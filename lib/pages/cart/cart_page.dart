import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        // iOS에서는 기본으로 AppBar title이 가운데 정렬되지만,
        // Android에서는 title이 왼쪽 정렬되기 때문에 centerTitle을 true로 설정
        centerTitle: true,
        title: Text('장바구니'),
        leading: Icon(Icons.arrow_back),
      ),
    );
  }
}
