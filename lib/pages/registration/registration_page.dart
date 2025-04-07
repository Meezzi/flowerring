import 'package:flowerring/pages/registration/widgets/product_text_field.dart';
import 'package:flutter/material.dart';

class RegistrationPage extends StatefulWidget {
  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _nameController = TextEditingController();
  final _stockController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();

  @override
  void dispose() {
    // 메모리 정리
    _nameController.dispose();
    _stockController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();

    super.dispose();
  }

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
        title: Text('상품등록'),
        centerTitle: true,
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
                        height: 320,
                        width: double.infinity,
                        color: Colors.grey[300]!,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add_a_photo_rounded, size: 80),
                            Text(
                              '사진을 선택해 주세요.',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ProductTextField(
                              label: '상품명',
                              hintText: '상품명을 입력해 주세요',
                              controller: _nameController,
                            ),
                            SizedBox(height: 12),
                            ProductTextField(
                              label: '상품가격',
                              hintText: '상품가격을 입력해 주세요.',
                              controller: _priceController,
                              keyboardType: TextInputType.number,
                            ),
                            SizedBox(height: 12),
                            ProductTextField(
                              label: '상품재고',
                              hintText: '상품재고를 입력해 주세요.',
                              controller: _stockController,
                              keyboardType: TextInputType.number,
                            ),
                            SizedBox(height: 12),
                            ProductTextField(
                              label: '상품설명',
                              hintText: '상품설명을 입력해 주세요.',
                              controller: _descriptionController,
                              maxLines: 7,
                              maxLength: 300,
                            ),
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
                onPressed: () {},
                style: ButtonStyle(
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  backgroundColor: WidgetStatePropertyAll(
                    Color.fromRGBO(255, 118, 118, 1),
                  ),
                  foregroundColor: WidgetStatePropertyAll(Colors.white),
                  textStyle: WidgetStatePropertyAll(
                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                child: Text('등록하기'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
