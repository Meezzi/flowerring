import 'package:flutter/material.dart';

class ListPage extends StatelessWidget {
  const ListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('플라워링'),
        actions: [Icon(Icons.shopping_cart_outlined), SizedBox(width: 25)],
      ),
    );
  }
}
