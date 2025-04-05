import 'package:flowerring/model/product.dart';
import 'package:flowerring/pages/detail/widgets/widget.dart';
import 'package:flowerring/pages/review/widgets/review_modal_widgets.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  final Product product;

  const DetailPage({super.key, required this.product});
  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late QuantityController quantityController;

  int selectedTabIndex = 0; // 0 = 상품설명, 1 = 리뷰

  @override
  void initState() {
    super.initState();
    quantityController = QuantityController(unitPrice: widget.product.price);
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
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              // 장바구니 이동 등
            },
          ),
        ],
      ),
      body: Column(
        children: [
          ///이미지 불러오는 변수 임의 설정(변동가능)
          GestureDetector(
            onTap: () {},
            child: Image.asset(
              product.imageUrl,
              height: 250,
              fit: BoxFit.cover,
            ),
          ),

          /// 제목 , 별점 ,가격 + 수량
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ///제목
                Text(
                  product.title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),

                ///별점
                Row(children: [buildStarRating(product.rate.toInt(), (_) {})]),

                ///더블을 인트로 변환 프로덕트와 별점 위젯 변수타입이 다름 나중에 별점 위젯 변수 타입 더블로 바꾸면 될듯
                const SizedBox(height: 8),

                ///가격 + 수량 조절
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${quantityController.totalPrice}원',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove),
                            onPressed: () {
                              quantityController.decrement();
                            },
                          ),
                          Text('${quantityController.quantity}'),
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () {
                              quantityController.increment();
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedTabIndex = 0;
                        });
                      },
                      child: Text(
                        '상품설명',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color:
                              selectedTabIndex == 0
                                  ? Colors.black
                                  : Colors.grey,
                        ),
                      ),
                    ),
                    SizedBox(width: 130),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedTabIndex = 1;
                        });
                      },
                      child: Text(
                        '리뷰',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color:
                              selectedTabIndex == 1
                                  ? Colors.black
                                  : Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),

                const Divider(),
              ],
            ),
          ),

          ///상품설명
          Expanded(
            child:
                selectedTabIndex == 0
                    ? ListView(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      children: [
                        const SizedBox(height: 8),

                        ///Text(product.description) 나중에 적용
                        Text('text'),
                        const SizedBox(height: 8),
                      ],
                    )
                    : ListView(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      children: const [
                        SizedBox(height: 8),
                        Text('⭐️ 4.8 | 총 20개의 리뷰가 있습니다'),
                        SizedBox(height: 8),
                        Text('“진짜 거의 새제품이었어요! 대박 만족 ”'),
                        SizedBox(height: 8),
                        Text('“배송도 빠르고 제품 상태 완전 좋아요.”'),
                        SizedBox(height: 8),
                        Text('“감사합니다! 다음에도 구매할게요.”'),
                      ],
                    ),
          ),
        ],
      ),

      ///하단 장바구니 + 결제 버튼
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            IconButton(icon: const Icon(Icons.shopping_cart), onPressed: () {}),
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Color.fromRGBO(255, 118, 118, 1.0),
                ),
                onPressed: () {
                  showPaymentConfirmationDialog(
                    context,
                    product,
                    quantityController,
                  );
                },
                child: const Text(
                  '결제하기',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
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
