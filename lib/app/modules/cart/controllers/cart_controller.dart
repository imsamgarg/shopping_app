import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shopping_app/app/core/utils/mixins/services_mixin.dart';
import 'package:shopping_app/app/data/models/cart_model.dart';

class CartController extends GetxController with ServicesMixin {
  late final instance = _getCartProducts();
  late final List<CartModel> cartItems = [];

  late final RxInt _finalPrice = calculateTotalPrice().obs;
  int get finalPrice => _finalPrice.value;
  set finalPrice(value) => _finalPrice.value = value;

  Future<bool> _getCartProducts() async {
    await cartService.init();
    convertCartMapToList();
    return true;
  }

  int calculateTotalPrice() {
    var price = 0;
    for (var item in cartItems) {
      price += item.fullPrice! * item.quantity;
    }
    return price;
  }

  void removeFromCart(BuildContext context, int index, Widget child) async {
    //remove from server
    await cartService.removeFromCart(cartItems[index]);
    //remove from list
    cartItems.removeAt(index);
    AnimatedList.of(context).removeItem(
      index,
      (_, animation) => SizeTransition(sizeFactor: animation, child: child),
    );
  }

  void convertCartMapToList() {
    for (var cartItem in cartService.cartItems.entries) {
      cartItems.add(cartItem.value);
    }
  }

  ///*No Longer Needed

  // void decrementQuantity(int index) {
  //   local to cart screen
  //   final item = cartItems[index];
  //   --item.quantity;

  //   globally
  //   final id = item.product!.id!;
  //   cartService.decrementQuantity(id);
  // }

  // void incrementQuantity(int index) {
  //   local to cart screen
  //   final item = cartItems[index];
  //   ++item.quantity;

  //   globally
  //   final id = item.product!.id!;
  //   cartService.incrementQuantity(id);
  // }

  void updateTotalPrice() {
    finalPrice = calculateTotalPrice();
  }
}
