import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {
  String buttonTitle;
  void Function() onPressed;

  CommonButton({required this.buttonTitle, required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: onPressed, child: Text(buttonTitle));
  }
}
