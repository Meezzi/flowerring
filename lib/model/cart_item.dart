import 'package:flowerring/model/product.dart';

class CartItem {
  final Product product;
  final int quantity;

  CartItem({required this.product, required this.quantity});
}

class Cart {
  final List<CartItem> _itemsInCart = [];

  List<CartItem> get items => _itemsInCart;

  void addProduct(Product product, int quantity) {
    _itemsInCart.add(CartItem(product: product, quantity: quantity));
  }
}
