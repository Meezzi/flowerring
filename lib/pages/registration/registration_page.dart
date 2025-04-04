import 'package:flutter/material.dart';

class RegistrationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text(
          '상품등록',
          style: TextStyle(
            fontSize: 12,
            color: const Color.fromRGBO(70, 74, 77, 1),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 390,
                        width: double.infinity,
                        color: Colors.grey[300],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            inputTextField('상품명', '상품명을 입력해 주세요.'),
                            SizedBox(height: 12),
                            inputTextField('상품가격', '상품가격을 입력해 주세요.'),
                            SizedBox(height: 12),
                            inputTextField('상품재고', '상품재고를 입력해 주세요.'),
                            SizedBox(height: 12),
                            inputTextField('상품설명', '상품설명을 입력해 주세요.'),
                            SizedBox(height: 12),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 8),
            Container(
              width: double.infinity,
              height: 48,
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: ElevatedButton(
                style: ButtonStyle(
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  backgroundColor: WidgetStatePropertyAll(
                    Color.fromRGBO(255, 76, 76, 1),
                  ),
                  foregroundColor: WidgetStatePropertyAll(Colors.white),
                  textStyle: WidgetStatePropertyAll(
                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                onPressed: () {},
                child: Text('등록하기'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget inputTextField(String label, String hintText) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: TextStyle(color: const Color.fromRGBO(70, 74, 77, 1))),
      SizedBox(height: 4),
      TextField(
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: hintText,
        ),
      ),
    ],
  );
}
