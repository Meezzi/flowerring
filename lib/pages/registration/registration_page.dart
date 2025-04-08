import 'package:flowerring/model/product.dart';
import 'package:flowerring/pages/registration/widgets/product_image_selector.dart';
import 'package:flowerring/pages/registration/widgets/product_text_field.dart';
import 'package:flutter/material.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  // image 관련
  String? _selectedImage;
  void onImageSelected(imagePath) {
    setState(() {
      _selectedImage = imagePath;
    });
  }

  // form 관련 변수
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _stockController = TextEditingController();
  final _contentController = TextEditingController();
  final _priceController = TextEditingController();

  @override
  void dispose() {
    // 메모리 정리
    _titleController.dispose();
    _stockController.dispose();
    _contentController.dispose();
    _priceController.dispose();

    super.dispose();
  }

  // 상품 입력폼 넘겨주기
  void _submitForm() {
    if (_selectedImage == null) {
      // 사진을 선택하지 않았으면
      showDialog(
        context: context,
        builder:
            (_) => AlertDialog(
              title: Text('입력 오류'),
              content: Text('사진을 선택해 주세요!'),
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
    // 유효성 검사에 성공하면!
    else if (_formKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder:
            (_) => AlertDialog(
              title: Text('상품등록 완료!'),
              content: Text('상품이 성공적으로 등록되었습니다!'),
              actions: [
                TextButton(
                  onPressed: () {
                    final title = _titleController.text;
                    final stock = _stockController.text;
                    final content = _contentController.text;
                    final price = _priceController.text;

                    Product product = Product(
                      id: 1,
                      title: title,
                      stock: int.tryParse(stock)!,
                      imageUrl: _selectedImage!,
                      content: content,
                      price: int.tryParse(price)!,
                      rate: 0,
                      reviewsCount: 0,
                      reviewIdList: [],
                    );
                    // 상품등록 코드 진행

                    Navigator.pop(context);
                    Navigator.pop(context, product);
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
                      ProductImageSelector(onImageSelected: onImageSelected),
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
                                controller: _titleController,
                                validator: titleValidator,
                                formKey: _formKey,
                              ),
                              SizedBox(height: 12),
                              ProductTextField(
                                label: '상품가격',
                                hintText: '상품가격을 입력해 주세요.',
                                controller: _priceController,
                                keyboardType: TextInputType.number,
                                validator: priceValidator,
                                formKey: _formKey,
                              ),
                              SizedBox(height: 12),
                              ProductTextField(
                                label: '상품재고',
                                hintText: '상품재고를 입력해 주세요.',
                                controller: _stockController,
                                keyboardType: TextInputType.number,
                                validator: stockValidator,
                                formKey: _formKey,
                              ),
                              SizedBox(height: 12),
                              ProductTextField(
                                label: '상품설명',
                                hintText: '상품설명을 입력해 주세요.',
                                controller: _contentController,
                                validator: contentValidator,
                                maxLines: 7,
                                maxLength: 300,
                                formKey: _formKey,
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

  String? titleValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return '상품명을 입력해 주세요!';
    }
    return null;
  }

  // 유효성 검사
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

  String? contentValidator(String? value) {
    if (value == null || value.isEmpty) {
      return '상품설명을 입력해 주세요';
    }
    return null;
  }
}
