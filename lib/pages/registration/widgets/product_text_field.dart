import 'package:flutter/material.dart';

class ProductTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final int maxLines;
  final int maxLength;
  final GlobalKey<FormState>? formKey;

  const ProductTextField({
    super.key,
    required this.label,
    required this.hintText,
    required this.controller,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
    this.maxLength = 15,
    this.formKey,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        SizedBox(height: 4),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          maxLength: maxLength,
          style: TextStyle(fontSize: 18),
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: hintText,
          ),
          validator: validator,
          onChanged: (_) {
            // 입력값이 바뀌면 유효성 검사 다시 실행
            if (formKey != null && formKey!.currentState != null) {
              formKey!.currentState!.validate();
            }
          },
        ),
      ],
    );
  }
}
