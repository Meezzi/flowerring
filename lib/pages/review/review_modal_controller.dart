import 'package:flutter/material.dart';
import './review_page.dart';

void showReviewModal(
  BuildContext context,
  VoidCallback onClose,
  Function(int, String) onSubmit, // 별점과 리뷰 내용을 함께 전달
) {
  showDialog(
    context: context,
    builder: (_) => ReviewModal(onClose: onClose, onSubmit: onSubmit),
  );
}