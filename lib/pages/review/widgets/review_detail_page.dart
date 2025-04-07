import 'package:flutter/material.dart';
import '../review_modal_controller.dart';

//리뷰 탭 타이틀
// ignore: camel_case_types
class headerTitle extends StatelessWidget {
  const headerTitle({super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Text(
        "후기",
        style: TextStyle(fontSize: 15, color: Color.fromRGBO(34, 34, 34, 1)),
      ),
    );
  }
}

//리뷰 탭 리뷰작성 버튼
// ignore: camel_case_types
class writeButton extends StatelessWidget {
  const writeButton({super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ElevatedButton(
        onPressed: () {
          showReviewModal(
            context,
            () {
              Navigator.of(context).pop(); // 모달 닫기
            },
            (rating) {
              // 리뷰 등록 후 처리할 로직 (예: 새로고침, 스낵바 등)
              print('사용자가 등록한 별점: $rating');
            },
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Color.fromRGBO(255, 118, 118, 1),
          surfaceTintColor: Color.fromRGBO(255, 118, 118, 1),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [Icon(Icons.add), SizedBox(width: 5), Text("리뷰 등록하기")],
        ),
      ),
    );
  }
}
