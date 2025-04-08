import 'package:flowerring/model/cart_item.dart';
import 'package:flowerring/model/product.dart';
import 'package:flowerring/pages/cart/cart_page.dart';
import 'package:flowerring/pages/detail/widgets/product_detail_controller.dart';
import 'package:flowerring/pages/detail/widgets/product_detail_page.dart';
import 'package:flowerring/pages/list/list_page.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  final Product product;
  final Function onPayment;

  const DetailPage({
    super.key,
    required this.product,
    required this.onPayment,
  });
  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late QuantityController quantityController;

  int selectedTabIndex = 0; // 0 = 상품설명, 1 = 리뷰

  @override
  void initState() {
    super.initState();
    quantityController = QuantityController(
      unitPrice: widget.product.price,
      stock: widget.product.stock,
    );
    quantityController.addListener(() {
      setState(() {}); // 수량 or 가격 변경 시 자동 UI 업데이트
    });
  }

  @override
  void dispose() {
    quantityController.dispose(); // 메모리 누수 방지
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    return Scaffold(
      backgroundColor: Colors.white,

      /// 전체 배경 흰색
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),

        title: Text(
          product.title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          Text(
            quantityController.quantity > 1
                ? '${quantityController.quantity}'
                : '',
            style: const TextStyle(
              fontSize: 15,
              color: Colors.black54,
              fontWeight: FontWeight.bold,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              ///싱글톤 카드에 추가
              Cart().addProduct(product, quantityController.quantity);

              // 장바구니 이동
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CartPage(onPayment: widget.onPayment),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          DetailImageSection(imageUrl: product.imageUrl),

          ///상세페이지 이미지
          DetailInfoSection(product: product, controller: quantityController),

          ///상세페이지 정보
          const SizedBox(height: 20),
          DetailTabSelector(
            ///상세페이지 상품설명,리뷰 선택
            selectedTab: selectedTabIndex,
            onTabChanged: (index) => setState(() => selectedTabIndex = index),
          ),

          ///상세페이지 상품 설명 리뷰 설명
          DetailContentView(tabIndex: selectedTabIndex, product: product),
          SizedBox(height: 30),
          Divider(height: 1),
        ],
      ),

      ///하단 장바구니 + 결제 버튼
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.shopping_cart),
                  onPressed: () {
                    ///싱글톤 카드에 추가
                    Cart().addProduct(product, quantityController.quantity);

                    // 장바구니 이동
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (_) => CartPage(onPayment: widget.onPayment),
                      ),
                    );
                  },
                ),

                Text(
                  quantityController.quantity > 1
                      ? '${quantityController.quantity}'
                      : '',
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(width: 12),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 13),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Color.fromRGBO(255, 118, 118, 1.0),
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    showPaymentConfirmationDialog(
                      context,
                      product,
                      quantityController,
                      
                  child: const Text(
                    '결제하기',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
