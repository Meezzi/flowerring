import 'package:flutter/material.dart';

class ProductRegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
      ),
    );
  }
}
