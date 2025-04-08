import 'package:flowerring/model/cart_item.dart';
import 'package:flowerring/model/product.dart';
import 'package:flowerring/pages/cart/cart_page.dart';
import 'package:flowerring/pages/detail/detail_page.dart';
import 'package:flowerring/pages/list/widgets/product_item.dart';
import 'package:flowerring/pages/registration/registration_page.dart';
import 'package:flutter/material.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  List<Product> _items = Product.getProducts();

  void checkout(List<CartItem> itemsInCart) {
    for (var cartItem in itemsInCart) {
      // 장바구니의 상품 ID와 일치하는 상품 찾기
      final productIndex = _items.indexWhere(
        (product) => product.id == cartItem.product.id,
      );

      // 상품의 재고에서 선택한 수량만큼 감소
      if (productIndex != -1) {
        setState(() {
          _items[productIndex].stock -= cartItem.quantity;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 상품 등록 버튼 클릭 시 등록 페이지 이동
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        onPressed: () async {
          Product product = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return RegistrationPage();
              },
            ),
          );
          print('product $product');
          product.id = _items.length + 1;
          setState(() {
            _items.add(product);
          });
        },
      ),
      appBar: AppBar(
        centerTitle: true,
        title: const Text('플라워링'),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart_outlined),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return CartPage(onPayment: checkout);
                  },
                ),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _items.length,
        itemBuilder: (context, index) {
          Product product = _items[index];

          ///리스트페이지에서 디테일페이지 이동하는 코드
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (_) => DetailPage(product: product, onPayment: checkout),
                ),
              );
            },
            child: ProductItem(product: product),
          );
        },
      ),
    );
  }
}
