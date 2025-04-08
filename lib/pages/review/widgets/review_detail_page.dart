import 'package:flutter/material.dart';
import '../review_modal_controller.dart';
import '../../../model/review.dart';

//리뷰 탭 타이틀
// ignore: camel_case_types
class HeaderTitle extends StatelessWidget {
  const HeaderTitle({super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Text(
        "후기",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Color.fromRGBO(34, 34, 34, 1),
        ),
      ),
    );
  }
}

// 리뷰 탭 리뷰작성 버튼
class WriteButton extends StatelessWidget {
  final VoidCallback onTap;

  const WriteButton({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ElevatedButton(
        onPressed: onTap,
        child: Row(
          children: const [
            Icon(Icons.add),
            SizedBox(width: 4),
            Text("리뷰 등록하기"),
          ],
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromRGBO(255, 118, 118, 1),
          surfaceTintColor: const Color.fromRGBO(255, 118, 118, 1),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}

// 리뷰 상태 위젯 (별점 평균 및 분포 표시)
class ReviewStatus extends StatelessWidget {
  final double averageRating;
  final int totalReviews;
  final List<int> ratingDistribution;

  const ReviewStatus({
    super.key,
    required this.averageRating,
    required this.totalReviews,
    required this.ratingDistribution,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(35, 8, 35, 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Color.fromRGBO(232, 238, 242, 1)),
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 왼쪽: 평균 별점과 총 리뷰 수
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.star,
                      color: Color.fromRGBO(70, 74, 77, 1),
                      size: 30,
                    ),
                    Text(
                      averageRating.toStringAsFixed(2),
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(255, 118, 118, 1),
                      ),
                    ),
                  ],
                ),
                Text(
                  "$totalReviews개",
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color.fromRGBO(68, 68, 68, 1),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            const SizedBox(width: 50),

            // 오른쪽: 별점 분포도
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  int rating = 5 - index;
                  int count = ratingDistribution[rating - 1];
                  double percentage =
                      totalReviews > 0 ? count / totalReviews : 0;

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3.0),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 20,
                          child: Text(
                            "$rating",
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(68, 68, 68, 1),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Stack(
                            children: [
                              Container(
                                height: 4,
                                decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                              FractionallySizedBox(
                                widthFactor: percentage,
                                child: Container(
                                  height: 4,
                                  decoration: BoxDecoration(
                                    color: const Color.fromRGBO(
                                      255,
                                      118,
                                      118,
                                      1,
                                    ),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 리뷰 리스트 위젯
class ReviewList extends StatelessWidget {
  final List<Review> reviews;

  const ReviewList({super.key, required this.reviews});

  @override
  Widget build(BuildContext context) {
    if (reviews.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 32.0),
        child: Center(
          child: Text(
            "리뷰가 없습니다.",
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: reviews.length,
      itemBuilder: (context, index) {
        final review = reviews[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 사용자 프로필 이미지
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(review.profileImageUrl),
                backgroundColor: Colors.grey.shade200,
              ),
              const SizedBox(width: 12),
              // 사용자 이름, 별점, 리뷰 내용
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 사용자 이름
                    Text(
                      review.username,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(34, 34, 34, 1),
                      ),
                    ),
                    const SizedBox(height: 4),
                    // 별점과 작성 날짜
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.yellow, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          review.rating.toStringAsFixed(1),
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(width: 8),
                      ],
                    ),
                    const SizedBox(height: 4),
                    // 리뷰 내용
                    Text(
                      review.content,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color.fromRGBO(34, 34, 34, 1),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
