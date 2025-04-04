import 'package:flutter/material.dart';
import './widgets/review_modal_widgets.dart';

class ReviewModal extends StatefulWidget {
  final VoidCallback onClose;
  final ValueChanged<int> onSubmit;

  const ReviewModal({Key? key, required this.onClose, required this.onSubmit})
    : super(key: key);

  @override
  State<ReviewModal> createState() => _ReviewModalState();
}

class _ReviewModalState extends State<ReviewModal> {
  int _rating = 0;
  final TextEditingController _reviewController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      // 모달 창 부모 위젯 구성
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
              buildSubmitButton(onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
