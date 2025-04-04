import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // 뒤로가기
          },
        ),
      ),
      body: Center(
        child: Column(
          children: [
            ///이미지 불러오는 변수 임의 설정(변동가능)
            Image.asset(
              'assets/images/iphone.png',
              height: 250,
              fit: BoxFit.cover,
            ),

            /// 제목 , 별점 ,가격 + 수량
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ///제목
                  Text(
                    '아이폰 15Pro 급처합니다.',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),

                  ///별점
                  Row(children: []),

                  const SizedBox(height: 8),

                  ///가격 + 수량 조절
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
