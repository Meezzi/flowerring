import 'package:flutter/material.dart';

class QuantityController extends ChangeNotifier {
  int _quantity = 1;
  int unitPrice;

  QuantityController({required this.unitPrice});

  int get quantity => _quantity;

  ///수량에 따라 자동으로 계산된 가격
  int get totalPrice => _quantity * unitPrice;

  void increment() {
    _quantity++;
    notifyListeners();

    ///수량과 총 가격 동시에 반영
  }

  void decrement() {
    if (quantity > 1) {
      _quantity--;
      notifyListeners();
    }
  }
}
