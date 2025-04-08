import 'package:flowerring/model/cart_item.dart';
import 'package:flowerring/utils/format_price.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ItemInCart extends StatefulWidget {
  final CartItem item;
  final VoidCallback onCartChanged;

  const ItemInCart({
    super.key,
    required this.item,
    required this.onCartChanged,
  });

  @override
  State<ItemInCart> createState() => _ItemInCartState();
}

class _ItemInCartState extends State<ItemInCart> {
  void _showStockExceededDialog() {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text('재고 초과'),
          content: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Text('재고보다 많은 수량은 담을 수 없습니다.'),
          ),
          actions: [
            CupertinoDialogAction(
              child: Text('확인'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _changeQuantity(bool increment) {
    if (increment) {
      bool success = Cart().addProduct(widget.item.product, 1);

      if (!success) {
        _showStockExceededDialog();
        return;
      }
    } else {
      if (widget.item.quantity > 1) {
        widget.item.quantity--;
      }
    }

    widget.onCartChanged();
  }

  void _removeProduct() {
    Cart().removeProduct(widget.item);
    widget.onCartChanged();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _checkAndDeleteCartItem(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _productImage(widget.item),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _itemTitle(widget.item.product.title),
                  SizedBox(height: 20),
                  _itemPrice(
                    widget.item.product.price *
                        widget.item.quantity,
                  ),
                ],
              ),
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(height: 40),
                _itemCounter(widget.item.quantity),
              ],
            ),
          ],
        ),
        SizedBox(height: 8),
        Divider(),
      ],
    );
  }

  Widget _productImage(CartItem item) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.asset(
        item.product.imageUrl,
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
    return Text('${formatPrice(price)}원');
  }

  Widget _itemCounter(int quantity) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _quantityStepButton(Icons.remove, false),
        _countValueBox(widget.item.quantity),
        _quantityStepButton(Icons.add, true),
      ],
    );
  }

  Widget _quantityStepButton(IconData icon, bool increment) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: IconButton(
        icon: Icon(icon, size: 16),
        onPressed: () => _changeQuantity(increment),
      ),
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
      child: Text(
        '$quantity',
        style: const TextStyle(fontSize: 14),
      ),
    );
  }

  Widget _closeButton() {
    return GestureDetector(
      onTap: _removeProduct,
      child: Icon(Icons.close, size: 20),
    );
  }
}
