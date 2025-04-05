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
      body: Center(
        child: Column(
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
                  Row(children: [buildStarRating(product.rate as int, (_) {})]),

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
                                quantityController.decrement;
                              },
                            ),
                            Text('${quantityController.quantity}'),
                            IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () {
                                quantityController.increment;
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 40),
                    child: Align(
                      alignment: Alignment.centerLeft,

                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: Text(
                              '상품설명',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(width: 20),
                          GestureDetector(
                            onTap: () {},
                            child: Text(
                              '리뷰',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Divider(),
                ],
              ),
            ),

            ///상품설명
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  SizedBox(height: 8),
                  Text('테스트'),

                  ///product.description 이건 나중에
                ],
              ),
            ),
            const Spacer(),
            const Divider(),

            ///하단 장바구니 + 결제 버튼
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.shopping_cart),
                    onPressed: () {},
                  ),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: Color.fromRGBO(255, 118, 118, 1.0),
                      ),
                      onPressed: () {},
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
          ],
        ),
      ),
    );
  }
}
