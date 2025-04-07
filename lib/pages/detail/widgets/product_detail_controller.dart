import 'package:flowerring/model/cart_item.dart';
import 'package:flowerring/model/product.dart';
import 'package:flowerring/pages/cart/cart_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///수량 클래스
class QuantityController extends ChangeNotifier {
  int _quantity = 1;
  int unitPrice;

  QuantityController({required this.unitPrice});

  ///수량에 따라 자동으로 계산된 가격
  int get quantity => _quantity;

  ///수량과 총 가격 동시에 반영
  int get totalPrice => _quantity * unitPrice;

  void increment() {
    if (_quantity < 100) {
      _quantity++;
      notifyListeners();
    }
  }

  void decrement() {
    if (quantity > 1) {
      _quantity--;
      notifyListeners();
    }
  }
}

///ios스타일 팝업 함수
void showPaymentConfirmationDialog(
  BuildContext context,
  Product product,
  QuantityController quantityController,
) {
  showCupertinoDialog(
    context: context,
    builder: (context) {
      return CupertinoAlertDialog(
        title: Text('결제 확인'),
        content: Text(
          '${product.title}을 ${quantityController.quantity}개 구매하시겠습니까?',
        ),
        actions: [
          CupertinoDialogAction(
            child: Text('취소'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          CupertinoDialogAction(
            child: Text('확인'),
            onPressed: () {
              Navigator.of(context).pop(); // 첫 번째 팝업

              showCupertinoDialog(
                context: context,
                builder: (context) {
                  return CupertinoAlertDialog(
                    title: Text('구매 완료'),
                    content: Text('결제가 완료되었습니다!'),
                    actions: [
                      CupertinoDialogAction(
                        child: Text('확인'),
                        onPressed: () {
                          Navigator.of(context).pop(); // 두 번째 팝업 닫기
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      );
    },
  );
}

///별 위젯
Widget starScore(double rating) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      for (int i = 0; i < 5; i++)
        Icon(
          rating >= i + 1
              ? Icons.star
              : rating >= i + 0.5
              ? Icons.star_half
              : Icons.star_border,
          color: Colors.yellow,
          size: 18,
        ),
      const SizedBox(width: 4),
      Text(
        rating.toStringAsFixed(1),
        style: const TextStyle(fontSize: 13, color: Colors.black),
      ),
    ],
  );
}
