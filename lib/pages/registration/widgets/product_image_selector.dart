import 'dart:math';

import 'package:flutter/material.dart';

class ProductImageSelector extends StatefulWidget {
  final void Function(String) onImageSelected;

  const ProductImageSelector({super.key, required this.onImageSelected});

  @override
  State<ProductImageSelector> createState() => _ProductImageSelectorState();
}

class _ProductImageSelectorState extends State<ProductImageSelector> {
  // image 관련
  final List<String> imagePaths = [
    'assets/images/apple.jpg',
    'assets/images/bag.png',
    'assets/images/nike_phantom_gx.png',
    'assets/images/sample.jpg',
  ];
  String? _selectedImage;

  // 이미지 선택하세요 클릭시 랜덤 이미지 보여주기
  void _showRandomImage() {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: Text('사진선택 완료'),
            content: Text('사진이 성공적으로 선택되었습니다.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  final random = Random();
                  final newImage =
                      imagePaths[random.nextInt(imagePaths.length)];
                  setState(() {
                    _selectedImage = newImage;
                  });
                  widget.onImageSelected(newImage); // 부모에게 알려주기!
                },
                child: Text('확인'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 320,
      width: double.infinity,
      color: Colors.grey[300]!,
      child:
          _selectedImage == null
              ? GestureDetector(
                onTap: _showRandomImage,
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
              )
              : Image.asset(_selectedImage!, fit: BoxFit.cover),
    );
  }
}
