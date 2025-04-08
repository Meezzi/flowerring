import 'package:flutter/material.dart';
import '../review_modal_controller.dart';
import '../../../model/review.dart';

//리뷰 탭 타이틀
// ignore: camel_case_types
class headerTitle extends StatelessWidget {
  const headerTitle({super.key});
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
class writeButton extends StatelessWidget {
  final VoidCallback onTap;

  const writeButton({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ElevatedButton(
        onPressed: onTap,
        child: Row(
          children: const [
            Icon(Icons.add),
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
class reviewStatus extends StatefulWidget {
  const reviewStatus({super.key});

  @override
  State<reviewStatus> createState() => _ReviewStatusState();
}

class _ReviewStatusState extends State<reviewStatus> {
  double averageRating = 4.86; // 초기 평균 별점
  int totalReviews = 468; // 초기 총 리뷰 개수
  List<int> ratingDistribution = [300, 100, 50, 10, 8]; // 초기 별점 분포 (5점~1점)

  // 새로운 리뷰를 추가하는 메서드
  void addReview(int newRating) {
    setState(() {
      // 새로운 리뷰를 추가
      totalReviews += 1;
      ratingDistribution[5 - newRating] += 1;

      // 평균 별점 재계산
      double totalScore = 0;
      for (int i = 0; i < 5; i++) {
        totalScore += (5 - i) * ratingDistribution[i];
      }
      averageRating = totalScore / totalReviews;
    });
  }

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
          crossAxisAlignment: CrossAxisAlignment.center, // 수직 중앙 정렬
          children: [
            // 왼쪽: 별점 평균, 리뷰 개수
            Column(
              mainAxisAlignment: MainAxisAlignment.center, // 수직 중앙 정렬
              crossAxisAlignment: CrossAxisAlignment.center, // 수평 중앙 정렬
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
                      averageRating.toStringAsFixed(2), // 소수점 2자리까지 표시
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
            const SizedBox(width: 50), // 왼쪽과 오른쪽 사이 간격
            // 오른쪽: 별점 분포 그래프
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center, // 수직 중앙 정렬
                children: List.generate(5, (index) {
                  int rating = 5 - index; // 5점부터 1점까지
                  int count = ratingDistribution[index];
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
class reviewList extends StatelessWidget {
  final List<Review> reviews;

  const reviewList({super.key, required this.reviews});

  @override
  Widget build(BuildContext context) {
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
