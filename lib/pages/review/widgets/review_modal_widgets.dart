import 'package:flutter/material.dart';

///닫기 버튼 (상단 우측정렬)
Widget buildCloseButton(VoidCallback onClose) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [IconButton(onPressed: onClose, icon: const Icon(Icons.close))],
  );
}



/// 별점 위젯
Widget buildStarRating(int currentRating, ValueChanged<int> onChanged) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: List.generate(5, (index) {
      return IconButton(
        icon: Icon(
          index < currentRating ? Icons.star : Icons.star_border,
          color: Colors.amber,
          size: 32,
        ),
        onPressed: () => onChanged(index + 1),
      );
    }),
  );
}

/// 리뷰 입력창
Widget buildReviewTextField(TextEditingController controller){
  return SizedBox(
    height: 500,
    child: TextField(
      controller: controller,
      maxLines: null,
      expands: true,
      decoration: const InputDecoration(
        hintText: "리뷰 내용을 입력하세요.",
        border : OutlineInputBorder(),
        contentPadding: EdgeInsets.only(top : 12, left: 12),
      ),
    )
  );
}