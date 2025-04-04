import 'package:flutter/material.dart';
import './review_page.dart';

void showReviewModal(
  BuildContext context,
  VoidCallback onClose,
  ValueChanged<int> onSubmit,
) {
  showDialog(
    context: context,
    builder: (_) => ReviewModal(onClose: onClose, onSubmit: onSubmit),
  );
}
