import 'package:flowerring/common/widgets/common_button.dart';
import 'package:flowerring/model/cart_item.dart';
import 'package:flowerring/model/product.dart';
import 'package:flowerring/pages/cart/cart_page.dart';
import 'package:flowerring/pages/detail/widgets/product_detail_controller.dart';
import 'package:flowerring/pages/detail/widgets/product_detail_page.dart';
import 'package:flowerring/pages/list/list_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  final Product product;
  final Function onPayment;

  const DetailPage({super.key, required this.product, required this.onPayment});
  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late QuantityController quantityController;

  int selectedTabIndex = 0; // 0 = 상품설명, 1 = 리뷰
  double averageRating = 0.0;
  int totalReviews = 0;

  @override
  void initState() {
    super.initState();
    quantityController = QuantityController(
      unitPrice: widget.product.price,
      product: widget.product,
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

  void updateRating(double newAverage, int newTotal) {
    setState(() {
      averageRating = newAverage;
      totalReviews = newTotal;
    });
  }

  Future<bool> handlePurchase() async {
    if (quantityController.quantity > widget.product.stock) {
      showCupertinoDialog(
        context: context,
        builder:
            (_) => CupertinoAlertDialog(
              title: Text('재고 부족'),
              content: Text('현재 재고가 없습니다.'),
              actions: [
                CupertinoDialogAction(
                  child: Text('확인'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
      );
      return false;
    }

    setState(() {
      widget.product.stock -= quantityController.quantity;
    });

    Cart().addProduct(widget.product, quantityController.quantity);
    quantityController.resetQuantity();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    return Scaffold(
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
            icon: const Icon(Icons.shopping_cart_outlined),
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
          DetailInfoSection(
            product: product,
            controller: quantityController,
            averageRating: averageRating,
            totalReviews: totalReviews,
          ),

          ///상세페이지 정보
          const SizedBox(height: 20),
          DetailTabSelector(
            ///상세페이지 상품설명,리뷰 선택
            selectedTab: selectedTabIndex,
            onTabChanged: (index) => setState(() => selectedTabIndex = index),
          ),

          ///상세페이지 상품 설명 리뷰 설명
          DetailContentView(
            tabIndex: selectedTabIndex,
            product: product,
            onRatingChanged: updateRating,
          ),
          SizedBox(height: 30),
          Divider(height: 1),
        ],
      ),

      /// 하단 장바구니 + 결제 버튼
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () {
                // 장바구니에 추가
                Cart().addProduct(product, quantityController.quantity);

                // 장바구니 페이지로 이동
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CartPage(onPayment: widget.onPayment),
                  ),
                );
              },
              child: Transform.translate(
                offset: const Offset(0, -6),
                child: Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey, width: 1.5),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.shopping_cart_outlined,
                        size: 24,
                        color: Colors.black,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '${quantityController.quantity}',
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.black54,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 13),
                child: CommonButton(
                  child: Text('결제하기'),
                  onPressed: () {
                    if (widget.product.stock == 0) {
                      // 재고가 0이면 결제창 띄우지 않고 경고만
                      showCupertinoDialog(
                        context: context,
                        builder:
                            (_) => CupertinoAlertDialog(
                              title: const Text('재고 부족'),
                              content: const Text('현재 재고가 없습니다.'),
                              actions: [
                                CupertinoDialogAction(
                                  child: const Text('확인'),
                                  onPressed: () => Navigator.of(context).pop(),
                                ),
                              ],
                            ),
                      );
                      return;
                    }
                    showPaymentConfirmationDialog(
                      context,
                      product,
                      quantityController,
                      onPurchase: handlePurchase,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
