import 'package:flutter/material.dart';
import './widgets/review_modal_widgets.dart';

class ReviewModal extends StatefulWidget {
  final VoidCallback onClose;
  final Function(int, String) onSubmit; // 별점과 리뷰 내용을 함께 전달

  const ReviewModal({Key? key, required this.onClose, required this.onSubmit})
      : super(key: key);

  @override
  State<ReviewModal> createState() => _ReviewModalState();
}

class _ReviewModalState extends State<ReviewModal> {
  int _rating = 0;
  final TextEditingController _reviewController = TextEditingController();

  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
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
                onPressed: () {
                  if (_rating > 0 && _reviewController.text.isNotEmpty) {
                    // 별점과 리뷰 내용을 상위 위젯으로 전달
                    widget.onSubmit(_rating, _reviewController.text);
                    widget.onClose(); // 모달 닫기
                  } else {
                    // 입력이 유효하지 않을 경우 경고 표시 (옵션)
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("별점과 리뷰 내용을 입력해주세요."),
                        duration: Duration(seconds: 2),
                      ),
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