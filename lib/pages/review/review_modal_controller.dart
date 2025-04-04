import 'package:flutter/material.dart';
import './review_page.dart';

void showReviewModal(
  BuildContext context,
  int productId,
  int userId,
  VoidCallback onClose,
  ValueChanged<int> onSubmit,
) {
  showDialog(
    context: context,
    builder:
        (_) => ReviewModal(
          productId: productId,
          userId: userId,
          onClose: onClose,
          onSubmit: onSubmit,
        ),
  );
}
