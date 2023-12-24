import 'package:online_groceries/models/product.dart';

class CartItem {
  CartItem({required this.product, required this.amonut})
      : price = product.price * amonut;

  final Product product;
  int amonut;
  late double price;
}
