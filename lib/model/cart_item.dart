import 'package:flowerring/model/product.dart';
import 'package:collection/collection.dart';

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

  bool addProduct(Product product, int quantity) {
    final existingItem = _itemsInCart.firstWhereOrNull(
      (item) => item.product.id == product.id,
    );

    // 현재 장바구니에 담긴 상품의 수량
    int currentQuantityInCart = existingItem?.quantity ?? 0;

    // 추가 후 예상 수량
    int totalQuantityAfterAdd = currentQuantityInCart + quantity;

    // 재고보다 장바구니에 담긴 상품이 많다면 추가 X
    if (totalQuantityAfterAdd > product.stock) return false;

    // 이미 존재하는 상품이면 수량만 증가
    if (existingItem != null) {
      existingItem.quantity += quantity;
    } else {
      // 장바구니에 없는 상품이면 새로 추가
      _itemsInCart.add(CartItem(product: product, quantity: quantity));
    }

    return true;
  }

  void removeProduct(CartItem product) {
    _itemsInCart.remove(product);
  }

  int getTotalPrice() {
    int totalPrice = 0;

    for (final item in items) {
      totalPrice += item.product.price * item.quantity;
    }
    return totalPrice;
  }

  void clearProduct() {
    _itemsInCart.clear();
  }
}
