import 'package:flowerring/pages/list/list_page.dart';
import 'package:flowerring/pages/registration/widgets/product_text_field.dart';
import 'package:flutter/material.dart';

class RegistrationPage extends StatefulWidget {
  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();

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

  void _submitForm() {
    // 유효성 검사에 성공하면!
    if (_formKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder:
            (_) => AlertDialog(
              title: Text('상품등록 완료!'),
              content: Text('상품이 성공적으로 등록되었습니다!'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('확인'),
                ),
              ],
            ),
      );
    } else {
      //유효성 검사에 실패하면
      showDialog(
        context: context,
        builder:
            (_) => AlertDialog(
              title: Text('입력 오류'),
              content: Text('모든 항목을 올바르게 입력해 주세요!'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('확인'),
                ),
              ],
            ),
      );
    }
    // final name = _nameController.text;
    // final stock = _stockController.text;
    // final description = _descriptionController.text;
    // final price = _priceController.text;

    // print('상품명: $name');
    // print('재고: $stock');
    // print('설명: $description');
    // print('가격: $price');
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
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ProductTextField(
                                label: '상품명',
                                hintText: '상품명을 입력해 주세요',
                                controller: _nameController,
                                validator: nameValidator,
                              ),
                              SizedBox(height: 12),
                              ProductTextField(
                                label: '상품가격',
                                hintText: '상품가격을 입력해 주세요.',
                                controller: _priceController,
                                keyboardType: TextInputType.number,
                                validator: priceValidator,
                              ),
                              SizedBox(height: 12),
                              ProductTextField(
                                label: '상품재고',
                                hintText: '상품재고를 입력해 주세요.',
                                controller: _stockController,
                                keyboardType: TextInputType.number,
                                validator: stockValidator,
                              ),
                              SizedBox(height: 12),
                              ProductTextField(
                                label: '상품설명',
                                hintText: '상품설명을 입력해 주세요.',
                                controller: _descriptionController,
                                validator: descriptionValidator,
                                maxLines: 7,
                                maxLength: 300,
                              ),
                              SizedBox(height: 12),
                            ],
                          ),
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
                onPressed: () {
                  _submitForm();
                },
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

  String? nameValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return '상품명을 입력해 주세요!';
    }
    return null;
  }

  String? priceValidator(String? value) {
    if (value == null || value.isEmpty) {
      return '가격을 입력해 주세요';
    }
    final price = int.tryParse(value);
    if (price == null) {
      // 문자열이 입력되면.
      return '숫자만 입력해 주세요';
    } else if (price >= 1000000) {
      return '가격은 1,000,000원 이상이 될 수 없습니다.';
    }
    return null;
  }

  String? stockValidator(String? value) {
    if (value == null || value.isEmpty) {
      return '상품재고를 입력해 주세요';
    }
    final stock = int.tryParse(value);
    if (stock == null) {
      // 문자열이 입력되면.
      return '숫자만 입력해 주세요';
    } else if (stock >= 100) {
      return '상품재고는 100개 이상이 될 수 없습니다.';
    }
    return null;
  }

  String? descriptionValidator(String? value) {
    if (value == null || value.isEmpty) {
      return '상품설명을 입력해 주세요';
    }
    return null;
  }
}
