import 'package:flutter/material.dart';

class ItemInCart extends StatelessWidget {
  const ItemInCart({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _checkAndDeleteCartItem(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _productImage(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _itemTitle(),
                SizedBox(height: 20),
                _itemPrice(),
              ],
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [SizedBox(height: 40), _itemCounter()],
            ),
          ],
        ),
      ],
    );
  }

  Widget _productImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.asset(
        'assets/images/bag.png',
        width: 80,
        height: 80,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _itemTitle() {
    return Text(
      '아이폰 15PRO 금처합니다.',
      style: TextStyle(fontWeight: FontWeight.bold),
    );
  }

  Widget _itemPrice() {
    return Text('153,300원');
  }

  Widget _itemCounter() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _quantityStepButton(Icons.remove),
        _countValueBox('1'),
        _quantityStepButton(Icons.add),
      ],
    );
  }

  Widget _quantityStepButton(IconData icon) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: IconButton(icon: Icon(icon, size: 16), onPressed: () {}),
    );
  }

  Widget _checkAndDeleteCartItem() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: [
              SizedBox(
                width: 24,
                height: 24,
                child: Checkbox(value: true, onChanged: null),
              ),
            ],
          ),
        ),
        _closeButton(),
      ],
    );
  }

  Widget _countValueBox(String count) {
    return Container(
      width: 36,
      height: 36,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.grey[300]!),
          bottom: BorderSide(color: Colors.grey[300]!),
        ),
      ),
      child: Text(count, style: const TextStyle(fontSize: 14)),
    );
  }

  Widget _closeButton() {
    return GestureDetector(
      onTap: () {},
      child: Icon(Icons.close, size: 20),
    );
  }
}
