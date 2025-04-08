import 'package:flowerring/model/product.dart';
import 'package:flowerring/model/review.dart';
import 'package:flowerring/pages/detail/widgets/product_detail_controller.dart';
import 'package:flowerring/pages/review/review_modal_controller.dart';
import 'package:flutter/material.dart';
import '../../review/widgets/review_detail_page.dart';
import 'package:intl/intl.dart';

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

  String formatPrice(int price) {
    final formatter = NumberFormat('#,###');
    return formatter.format(price);
  }

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
                '${formatPrice(controller.totalPrice)}원',
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
                    onPressed: () => controller.increment(context),
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
    return Column(
      children: [
        // 탭 선택 영역
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => onTabChanged(0),
                child: Column(
                  children: [
                    Text(
                      '상품설명',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: selectedTab == 0 ? Colors.black : Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () => onTabChanged(1),
                child: Column(
                  children: [
                    Text(
                      '리뷰',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: selectedTab == 1 ? Colors.black : Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ),
          ],
        ),
        // 전체 라인 + 하이라인
        Stack(
          children: [
            Container(
              height: 2,
              width: double.infinity,
              color: Colors.grey.shade300,
            ),
            Align(
              alignment:
                  selectedTab == 0
                      ? Alignment.centerLeft
                      : Alignment.centerRight,
              child: FractionallySizedBox(
                widthFactor: 0.5,
                child: Container(height: 2, color: Colors.black),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// 상세페이지 상품설명 리뷰 내용 클래스
class DetailContentView extends StatefulWidget {
  final int tabIndex;
  final Product product;

  const DetailContentView({
    required this.tabIndex,
    required this.product,
    super.key,
  });

  @override
  State<DetailContentView> createState() => _DetailContentViewState();
}

class _DetailContentViewState extends State<DetailContentView> {
  List<Review> _reviews = [];

  double get averageRating {
    if (_reviews.isEmpty) return 0.0;
    double sum = _reviews.fold(0.0, (acc, r) => acc + r.rating);
    return sum / _reviews.length;
  }

  int get totalReviews => _reviews.length;

  List<int> get ratingDistribution {
    List<int> distribution = List.filled(5, 0); // index 0 = 1점, ..., 4 = 5점
    for (var review in _reviews) {
      int index = review.rating.round() - 1;
      if (index >= 0 && index < 5) {
        distribution[index]++;
      }
    }
    return distribution;
  }

  // 리뷰 추가 함수
  void _addReview(int rating, String content) {
    final newReview = Review(
      username: '익명 사용자',
      profileImageUrl: 'https://via.placeholder.com/150',
      rating: rating.toDouble(),
      content: content,
      formattedDate: DateTime.now().toString().split(' ').first,
    );

    setState(() {
      _reviews.insert(0, newReview); // 최신순으로 추가
    });
  }

  void _openReviewModal() {
    showReviewModal(context, () => Navigator.of(context).pop(), (
      int rating,
      String content,
    ) {
      _addReview(rating, content); // 리뷰 추가 함수
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child:
          widget.tabIndex == 0
              ? ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: const [
                  SizedBox(height: 8),
                  Text('테스트설명'),
                  SizedBox(height: 8),
                ],
              )
              : Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const headerTitle(),
                          writeButton(onTap: _openReviewModal),
                        ],
                      ),
                      const SizedBox(height: 15),
                      ReviewStatus(
                        averageRating: averageRating,
                        totalReviews: totalReviews,
                        ratingDistribution: ratingDistribution,
                      ),
                      const SizedBox(height: 15),
                      reviewList(reviews: _reviews),
                    ],
                  ),
                ),
              ),
    );
  }
}
