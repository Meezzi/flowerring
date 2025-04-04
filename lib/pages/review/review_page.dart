import 'package:flutter/material.dart';
import './widgets/review_modal_widgets.dart';
import '../../core/database_core.dart';

class ReviewModal extends StatefulWidget {
  final VoidCallback onClose;
  final ValueChanged<int> onSubmit;
  final int productId;
  final int userId;

  const ReviewModal({
    Key? key,
    required this.onClose,
    required this.onSubmit,
    required this.productId,
    required this.userId,
  }) : super(key: key);

  @override
  State<ReviewModal> createState() => _ReviewModalState();
}

class _ReviewModalState extends State<ReviewModal> {
  int _rating = 0;
  final TextEditingController _reviewController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: SizedBox(
        width: 560,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              buildCloseButton(widget.onClose),
              const SizedBox(height: 16),
              buildStarRating(_rating, (val) {
                setState(() {
                  _rating = val;
                });
              }),
              const SizedBox(height: 16),
              buildReviewTextField(_reviewController),
              const SizedBox(height: 16),
              buildSubmitButton(
                onPressed: () async {
                  final reviewText = _reviewController.text;
                  final rating = _rating;

                  if (reviewText.isEmpty || rating == 0) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("리뷰 내용과 별점을 모두 입력해주세요.")),
                    );
                    return;
                  }

                  try {
                    final insertedId = await DatabaseHelper.instance
                        .insertReview(
                          productId: widget.productId,
                          userId: widget.userId,
                          reviewText: reviewText,
                          reviewRating: rating,
                        );

                    if (insertedId > 0) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("리뷰가 등록되었습니다.")),
                      );
                      widget.onSubmit(insertedId); // 등록 후 콜백 호출
                      widget.onClose(); // 모달 닫기
                    }
                  } catch (e) {
                    debugPrint("리뷰 등록 실패: $e");
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("리뷰 등록 중 오류가 발생했습니다.")),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
