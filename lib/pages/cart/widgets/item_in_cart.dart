import 'package:flutter/material.dart';

class ItemInCart extends StatelessWidget {
  const ItemInCart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CountButton(),
    );
  }

  Widget countButton() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // 마이너스 버튼
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
          ),
          child: IconButton(
            icon: const Icon(Icons.remove, size: 16),
            onPressed: () {},
            constraints: const BoxConstraints(),
          ),
        ),

        // 숫자 표시
        Container(
          width: 36,
          height: 36,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(color: Colors.grey),
              bottom: BorderSide(color: Colors.grey),
            ),
          ),
          child: const Text(
            '1',
            style: TextStyle(fontSize: 14),
          ),
        ),

        // 플러스 버튼
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
          ),
          child: IconButton(
            icon: const Icon(Icons.add, size: 16),
            onPressed: () {},
            constraints: const BoxConstraints(),
          ),
        ),
      ],
    );
  }
}
