import 'package:flutter/material.dart';
import 'package:flowerring/pages/cart/widgets/item_in_cart.dart';
import 'package:flowerring/pages/cart/widgets/payment_summary.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final itemCount = 5;
  final int productPrice = 20600;
  final int deliveryFee = 0;

  @override
  Widget build(BuildContext context) {
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
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16),
              itemCount: itemCount + 1,
              itemBuilder: (context, index) {
                if (index == itemCount) {
                  // item이 모두 표시되면 마지막으로 결제 정보 표시
                  return Column(
                    children: [
                      const Divider(height: 32),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: PaymentSummary(
                          productPrice: productPrice,
                          deliveryFee: deliveryFee,
                        ),
                      ),
                    ],
                  );
                }
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: ItemInCart(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _payButton() {
    return ElevatedButton(
      onPressed: () {},
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
