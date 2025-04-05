import 'package:flowerring/model/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///수량 클래스
class QuantityController extends ChangeNotifier {
  int _quantity = 1;
  int unitPrice;

  QuantityController({required this.unitPrice});

  ///수량에 따라 자동으로 계산된 가격

  int get quantity => _quantity;

  ///수량과 총 가격 동시에 반영

  int get totalPrice => _quantity * unitPrice;

  void increment() {
    if (_quantity < 100) {
      _quantity++;
      notifyListeners();
    }
  }

  void decrement() {
    if (quantity > 1) {
      _quantity--;
      notifyListeners();
    }
  }
}

///ios스타일 팝업 함수
void showPaymentConfirmationDialog(
  BuildContext context,
  Product product,
  QuantityController quantityController,
) {
  showCupertinoDialog(
    context: context,
    builder: (context) {
      return CupertinoAlertDialog(
        title: Text('결제 확인'),
        content: Text(
          '${product.title}을 ${quantityController.quantity}개 구매하시겠습니까?',
        ),
        actions: [
          CupertinoDialogAction(
            child: Text('취소'),
            onPressed: () {
              Navigator.of(context).pop();

              ///첫번째 팝업 닫기
            },
          ),
          CupertinoDialogAction(
            child: Text('확인'),
            onPressed: () {
              Navigator.of(context).pop(); // 첫 번째 팝업 닫기
              showCupertinoDialog(
                context: context,
                builder: (context) {
                  return CupertinoAlertDialog(
                    title: Text('구매 완료'),
                    content: Text('결제가 완료되었습니다!'),
                    actions: [
                      CupertinoDialogAction(
                        child: Text('확인'),
                        onPressed: () {
                          Navigator.of(context).pop(); // 두 번째 팝업 닫기
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      );
    },
  );
}

///상세페이지 이미지 클래스
class DetailImageSection extends StatelessWidget {
  final String imageUrl;
  const DetailImageSection({required this.imageUrl, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Image.asset(imageUrl, height: 250, fit: BoxFit.cover),
    );
  }
}

///상세페이지 정보 클래스
class DetailInfoSection extends StatelessWidget {
  final Product product;
  final QuantityController controller;

  const DetailInfoSection({
    required this.product,
    required this.controller,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            product.title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Row(children: [starScore(product.rate)]),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${controller.totalPrice}원',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: controller.decrement,
                  ),
                  Text('${controller.quantity}'),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: controller.increment,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

///상세페이지 상품설명, 리뷰 선택 클래스
class DetailTabSelector extends StatelessWidget {
  final int selectedTab;
  final Function(int) onTabChanged;

  const DetailTabSelector({
    required this.selectedTab,
    required this.onTabChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () => onTabChanged(0),
          child: Text(
            '상품설명',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: selectedTab == 0 ? Colors.black : Colors.grey,
            ),
          ),
        ),
        const SizedBox(width: 130),
        GestureDetector(
          onTap: () => onTabChanged(1),
          child: Text(
            '리뷰',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: selectedTab == 1 ? Colors.black : Colors.grey,
            ),
          ),
        ),
      ],
    );
  }
}

/// 상세페이지 상품설명 리뷰 내용 클래스
class DetailContentView extends StatelessWidget {
  final int tabIndex;
  final Product product;

  const DetailContentView({
    required this.tabIndex,
    required this.product,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child:
          tabIndex == 0
              ? ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  const SizedBox(height: 8),
                  Text('테스트설명'),

                  ///Text(product.description), 실제 상품 설명 나중에 설정
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
    );
  }
}

///별 위젯
Widget starScore(double rating) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      for (int i = 0; i < 5; i++)
        Icon(
          rating >= i + 1
              ? Icons.star
              : rating >= i + 0.5
              ? Icons.star_half
              : Icons.star_border,
          color: Colors.yellow,
          size: 18,
        ),
      const SizedBox(width: 4),
      Text(
        rating.toStringAsFixed(1),
        style: const TextStyle(fontSize: 13, color: Colors.black),
      ),
    ],
  );
}
