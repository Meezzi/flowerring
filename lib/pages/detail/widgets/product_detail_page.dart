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
class DetailInfoSection extends StatefulWidget {
  final Product product;
  final QuantityController controller;
  final double averageRating;
  final int totalReviews;

  const DetailInfoSection({
    required this.product,
    required this.controller,
    required this.averageRating,
    required this.totalReviews,
    super.key,
  });

  @override
  State<DetailInfoSection> createState() => _DetailInfoSectionState();
}

class _DetailInfoSectionState extends State<DetailInfoSection> {
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
            widget.product.title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              starScore(context, widget.averageRating),
              SizedBox(width: 20),
              Text(
                '리뷰 ${widget.totalReviews}개',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${formatPrice(widget.controller.totalPrice)}원',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),

              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: widget.controller.decrement,
                  ),
                  Text('${widget.controller.quantity}'),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () => widget.controller.increment(context),
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
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return DefaultTabController(
      length: 2,
      initialIndex: selectedTab,
      child: Builder(
        builder: (context) {
          final TabController tabController = DefaultTabController.of(context);

          // 탭 변경 시 콜백 호출
          tabController.addListener(() {
            if (!tabController.indexIsChanging &&
                tabController.index != selectedTab) {
              onTabChanged(tabController.index);
            }
          });

          return Column(
            children: [
              TabBar(
                controller: tabController,
                tabs: const [Tab(text: '상품설명'), Tab(text: '리뷰')],
                labelColor: isDark ? Colors.white : Colors.black,
                unselectedLabelColor: Colors.grey,
                labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                indicator: const BoxDecoration(),
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 1.2,
                      color:
                          selectedTab == 0
                              ? (isDark ? Colors.white : Colors.black)
                              : (isDark
                                  ? Colors.grey.shade700
                                  : Colors.grey.shade300),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 1.2,
                      color:
                          selectedTab == 1
                              ? (isDark ? Colors.white : Colors.black)
                              : (isDark
                                  ? Colors.grey.shade700
                                  : Colors.grey.shade300),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

/// 상세페이지 상품설명 리뷰 내용 클래스
class DetailContentView extends StatefulWidget {
  final int tabIndex;
  final Product product;
  final Function(double averageRating, int totalReviews) onRatingChanged;

  const DetailContentView({
    required this.tabIndex,
    required this.product,
    required this.onRatingChanged,
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

    /// 리뷰 추가 후 평균 별점 계산 & 상위 콜백 호출
    final sum = _reviews.fold(0.0, (acc, r) => acc + r.rating);
    final average = sum / _reviews.length;
    widget.onRatingChanged(average, _reviews.length);
  }

  void _openReviewModal() {
    showReviewModal(context, () => Navigator.of(context).pop(), (
      int rating,
      String content,
    ) {
      _addReview(rating, content); // 리뷰 추가
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child:
          widget.tabIndex == 0
              ? ListView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 22,
                ),
                children: [
                  SizedBox(height: 8),
                  Text(
                    '재고: ${widget.product.stock}개',
                    textAlign: TextAlign.right,

                    style: const TextStyle(fontSize: 13),
                  ),
                  Text(
                    widget.product.content,
                    style: const TextStyle(fontSize: 15),
                  ),
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
                          const HeaderTitle(),
                          WriteButton(onTap: _openReviewModal),
                        ],
                      ),
                      const SizedBox(height: 15),
                      ReviewStatus(
                        averageRating: averageRating,
                        totalReviews: totalReviews,
                        ratingDistribution: ratingDistribution,
                      ),
                      const SizedBox(height: 15),
                      ReviewList(reviews: _reviews),
                    ],
                  ),
                ),
              ),
    );
  }
}
