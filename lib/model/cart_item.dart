import 'package:flowerring/model/product.dart';

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, required this.quantity});
}

class Cart {
  ///내부에서 자기 자신 인스턴스를 저장
  static final Cart _instance = Cart._internal();

  ///외부에서 호출할 때는 이걸로만 생성됨
  factory Cart() {
    return _instance;
  }

  ///진짜 생성자는 private
  Cart._internal();

  ///내부 상태관리
  final List<CartItem> _itemsInCart = [];

  List<CartItem> get items => _itemsInCart;

  void addProduct(Product product, int quantity) {
    _itemsInCart.add(CartItem(product: product, quantity: quantity));
  }

  int getTotalPrice() {
    int totalPrice = 0;

    for(final item in items) {
      totalPrice += item.product.price * item.quantity;
    }
    return totalPrice;
  }
}
