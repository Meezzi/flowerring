import 'package:flowerring/model/product.dart';
import 'package:flowerring/pages/detail/widgets/product_detail_controller.dart';
import 'package:flutter/material.dart';

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
