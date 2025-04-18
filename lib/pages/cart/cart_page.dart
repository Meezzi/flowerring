import 'package:flowerring/common/widgets/common_button.dart';
import 'package:flowerring/common/widgets/dialog_helper.dart';
import 'package:flowerring/model/cart_item.dart';
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
    final selectedItems = cartItems.where((item) => item.isSelected).toList();
    final productPrice = selectedItems.fold(
      0,
      (total, item) => total + item.product.price * item.quantity,
    );

    return Scaffold(
      appBar: AppBar(
        // iOS에서는 기본으로 AppBar title이 가운데 정렬되지만,
        // Android에서는 title이 왼쪽 정렬되기 때문에 centerTitle을 true로 설정
        centerTitle: true,
        title: Text('장바구니'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
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
          Text('상품이 없습니다.', style: TextStyle(fontSize: 18, color: Colors.grey)),
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
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            width: double.infinity,
            child: CommonButton(onPressed: onPressed, child: Text('결제하기')),
          ),
        ),
      ],
    );
  }

  void onPressed() {
    final selectedItems =
        Cart().items.where((item) => item.isSelected).toList();

    // 선택한 상품이 비어있으면 Dialog 표시
    if (selectedItems.isEmpty) {
      DialogHelper.showCupertinoYesNoDialog(
        context: context,
        title: '알림',
        content: '결제할 상품을 선택해주세요',
      );
      return;
    }

    // 선택한 상품만 결제
    DialogHelper.showCupertinoYesNoDialog(
      context: context,
      title: '결제',
      content: '선택한 상품을 결제하시겠어요?',
      onYes: () {
        widget.onPayment(selectedItems);

        for (final item in selectedItems) {
          Cart().removeProduct(item);
        }

        Navigator.pop(context);
        Navigator.pop(context);
      },
    );
  }
}
