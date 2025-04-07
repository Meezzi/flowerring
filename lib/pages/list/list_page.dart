import 'package:flowerring/model/product.dart';
import 'package:flowerring/pages/detail/detail_page.dart';
import 'package:flowerring/pages/list/widgets/product_item.dart';
import 'package:flowerring/pages/registration/registration_page.dart';
import 'package:flutter/material.dart';

class ListPage extends StatelessWidget {
  const ListPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Product.getProducts()로 상품 데이터 가져오기
    final List<Product> items = Product.getProducts();
    return Scaffold(
      // 상품 등록 버튼 클릭 시 등록 페이지 이동
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromRGBO(255, 118, 118, 1),
        foregroundColor: Colors.white,
        child: Icon(Icons.add),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return RegistrationPage();
              },
            ),
          );
        },
      ),
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

          ///리스트페이지에서 디테일페이지 이동하는 코드
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => DetailPage(product: product)),
              );
            },
            child: ProductItem(product: product),
          );
        },
      ),
    );
  }
}
