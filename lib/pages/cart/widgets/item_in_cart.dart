import 'package:flowerring/model/cart_item.dart';
import 'package:flutter/material.dart';

class ItemInCart extends StatelessWidget {
  final CartItem item;

  const ItemInCart({super.key, required this.item});

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
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _itemTitle(item.product.title),
                  SizedBox(height: 20),
                  _itemPrice(item.product.price),
                ],
              ),
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [SizedBox(height: 40), _itemCounter(item.quantity)],
            ),
          ],
        ),
        SizedBox(height: 8),
        Divider(),
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

  Widget _itemTitle(String title) {
    return Text(
      title,
      style: TextStyle(fontWeight: FontWeight.bold),
    );
  }

  Widget _itemPrice(int price) {
    return Text('$price원');
  }

  Widget _itemCounter(int quantity) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _quantityStepButton(Icons.remove),
        _countValueBox(quantity),
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

  Widget _countValueBox(int quantity) {
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
      child: Text('$quantity', style: const TextStyle(fontSize: 14)),
    );
  }

  Widget _closeButton() {
    return GestureDetector(
      onTap: () {},
      child: Icon(Icons.close, size: 20),
    );
  }
}
