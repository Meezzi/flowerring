import 'package:flowerring/model/cart_item.dart';
import 'package:flowerring/pages/list/list_page.dart';
import 'package:flutter/material.dart';
import 'package:flowerring/pages/cart/widgets/item_in_cart.dart';
import 'package:flowerring/pages/cart/widgets/payment_summary.dart';

class CartPage extends StatefulWidget {
  final Function onPayment;

  CartPage({super.key, required this.onPayment});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final int deliveryFee = 0;

  @override
  Widget build(BuildContext context) {
    final cart = Cart();
    final cartItems = cart.items;
    final productPrice = cart.getTotalPrice();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        // iOS에서는 기본으로 AppBar title이 가운데 정렬되지만,
        // Android에서는 title이 왼쪽 정렬되기 때문에 centerTitle을 true로 설정
        centerTitle: true,
        title: Text('장바구니'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.white,
        // 스크롤해도 색상이 달라지지 않도록 설정
        scrolledUnderElevation: 0,
      ),
      body:
          cartItems.isEmpty
              ? _emptyCartMessage()
              : _itemInCart(cartItems, productPrice),
    );
  }

  Widget _emptyCartMessage() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.shopping_cart_outlined, size: 80, color: Colors.grey),
          SizedBox(height: 16),
          Text(
            '상품이 없습니다.',
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _itemInCart(List<CartItem> cartItems, int productPrice) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 16),
            itemCount: cartItems.length + 1,
            itemBuilder: (context, index) {
              if (index == cartItems.length) {
                // item이 모두 표시되면 마지막으로 결제 정보 표시
                return Column(
                  children: [
                    PaymentSummary(
                      productPrice: productPrice,
                      deliveryFee: deliveryFee,
                    ),
                  ],
                );
              }
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: ItemInCart(
                  item: cartItems[index],
                  onCartChanged: () => setState(() {}),
                ),
              );
            },
          ),
        ),

        Padding(
          padding: const EdgeInsets.only(
            left: 12.0,
            right: 12.0,
            bottom: 12.0,
          ),
          child: SizedBox(width: double.infinity, child: _payButton()),
        ),
      ],
    );
  }

  Widget _payButton() {
    return ElevatedButton(
      onPressed: () {
        widget.onPayment(Cart().items);
        Cart().clearProduct();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => ListPage()),
        );
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: const Color.fromRGBO(255, 118, 118, 1.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: const Text(
        '결제하기',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }
}
