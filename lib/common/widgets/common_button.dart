import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {
  void Function() onPressed;
  Widget child;

  CommonButton({required this.onPressed, required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: onPressed, child: child);
  }
}
