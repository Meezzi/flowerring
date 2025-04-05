import 'package:flowerring/model/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class QuantityController extends ChangeNotifier {
  int _quantity = 1;
  int unitPrice;

  QuantityController({required this.unitPrice});

  int get quantity => _quantity;

  ///수량에 따라 자동으로 계산된 가격
  int get totalPrice => _quantity * unitPrice;

  void increment() {
    if (_quantity < 100) {
      _quantity++;
      notifyListeners();
    }

    ///수량과 총 가격 동시에 반영
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

              ///첫번째 팝업 닫기
            },
          ),
          CupertinoDialogAction(
            child: Text('확인'),
            onPressed: () {
              Navigator.of(context).pop(); // 첫 번째 팝업 닫기
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
