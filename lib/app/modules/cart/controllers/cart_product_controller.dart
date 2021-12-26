import 'package:get/get.dart';
import 'package:shopping_app/app/core/utils/mixins/services_mixin.dart';

import 'cart_controller.dart';

class CartProductController extends GetxController with ServicesMixin {
  late final cartController = Get.find<CartController>();
  late final cartItems = cartController.cartItems;

  late final List<RxInt> productPriceList = cartItems.map((e) {
    return RxInt(e.fullPrice! * e.quantity);
  }).toList(growable: false);

  int productPrice(int index) {
    return productPriceList[index].value;
  }

  bool isInStock(int index) {
    final item = cartItems[index];

    //item is in stock
    if (!item.product!.inStock!) return false;

    //check color is in stock
    final color = item.color;
    if (color != null) {
      final isAvailable = item.product?.color?.containsKey(color) ?? false;
      if (!isAvailable) return false;
    }

    //check size is in stock
    final size = item.size;
    if (size != null) {
      final isAvailable = item.product?.size?.containsKey(size) ?? false;
      if (!isAvailable) return false;
    }

    //item is available
    return true;
  }

  int productPrice(int index) {
    final cart = cartItems[index];
    final product = cart.product!;

    int price = cart.product!.price!;

    //check color price
    final color = cart.color;
    if (color != null && product.color != null) {
      price += product.color![color]!.priceDifferce!;
    }

    //check size price
    final size = cart.size;
    if (size != null && product.size != null) {
      price += product.size![size]!;
    }

    return price;
  }

  void changeQuantity(int index, int quantity) {
    //local to cart screen
    final item = cartItems[index];
    item.quantity = quantity;

    //globally
    final id = item.product!.id!;
    cartService.changeQuantity(id, quantity);

    //update total price ui
    cartController.updateTotalPrice();

    //update item price
    final price = item.product!.price! * item.quantity;
    productPriceList[index].value = price;
  }
}
