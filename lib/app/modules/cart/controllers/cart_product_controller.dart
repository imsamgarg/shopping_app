import 'package:get/get.dart';

import 'package:shopping_app/app/core/utils/mixins/services_mixin.dart';
import 'package:shopping_app/app/core/values/values.dart';

import 'cart_controller.dart';

class ProductDetail {
  int quantity;
  int price;

  ProductDetail({required this.quantity, required this.price});
}

class CartProductController extends GetxController with ServicesMixin {
  late final cartController = Get.find<CartController>();
  late final cartItems = cartController.cartItems;

  late final List<Rx<ProductDetail>> productDetailList = cartItems.map((e) {
    final quantity = e.quantity;
    final price = e.fullPrice! * quantity;
    return Rx(ProductDetail(quantity: quantity, price: price));
  }).toList();

  int productPrice(int index) {
    return productDetailList[index].value.price;
  }

  ProductAvailability checkAvailability(int index) {
    final item = cartItems[index];

    if (item.product == null) {
      return ProductAvailability.productDeleted;
    }

    if (!(item.inStock ?? false)) {
      return ProductAvailability.notAvailable;
    }
    if (item.isColorInStock == false) {
      return ProductAvailability.colorNotAvailable;
    }
    if (item.isSizeInStock == false) {
      return ProductAvailability.sizeNotAvailable;
    }

    return ProductAvailability.available;
  }
  ////* No Longer Used
  // void changeProductQuantity(int index, int quantity) {
  //   //?local to cart screen
  //   final item = cartItems[index];
  //   item.quantity = quantity;

  //   //?globally
  //   final id = item.product!.id!;
  //   cartService.changeQuantity(id, quantity);

  //   //?update total price ui
  //   cartController.updateTotalPrice();

  //   //?update item price
  //   updateProductPrice(index);
  // }

  void decrementQuantity(int index) {
    // local to cart screen
    final item = cartItems[index];

    if (item.quantity == kProductMinQuantity) {
      return;
    }
    // --item.quantity;

    // globally
    final id = item.product!.id!;
    cartService.decrementQuantity(id);

    updatePriceChanges(index);
    updateQuantityChanges(index, item.quantity);
  }

  void incrementQuantity(int index) {
    // local to cart screen
    final item = cartItems[index];

    if (item.quantity >= kProductMaxQuantity) {
      return;
    }
    // ++item.quantity;

    // globally
    final id = item.product!.id!;
    cartService.incrementQuantity(id);

    updatePriceChanges(index);
    updateQuantityChanges(index, item.quantity);
  }

  void updateProductPrice(int index) {
    final item = cartItems[index];

    //calculate full price
    final price = item.fullPrice! * item.quantity;
    productDetailList[index].update((val) => val?.price = price);
  }

  void updatePriceChanges(int index) {
    //update total price ui
    cartController.updateTotalPrice();

    //update item price
    updateProductPrice(index);
  }

  void removeProductDetail(int index) {
    //close subscription
    // productDetailList[index]();
    //remove state
    productDetailList.removeAt(index);
  }

  void updateQuantityChanges(int index, int quantity) {
    productDetailList[index].update((val) => val?.quantity = quantity);
  }
}

// bool isInStock(int index) {
//   final item = cartItems[index];

//   //item is in stock
//   if (!item.product!.inStock!) return false;

//   //check color is in stock
//   final color = item.color;
//   if (color != null) {
//     final isAvailable = item.product?.color?.containsKey(color) ?? false;
//     if (!isAvailable) return false;
//   }

//   //check size is in stock
//   final size = item.size;
//   if (size != null) {
//     final isAvailable = item.product?.size?.containsKey(size) ?? false;
//     if (!isAvailable) return false;
//   }

//   //item is available
//   return true;
// }

// int productPrice(int index) {
//   final cart = cartItems[index];
//   final product = cart.product!;

//   int price = cart.product!.price!;

//   //check color price
//   final color = cart.color;
//   if (color != null && product.color != null) {
//     price += product.color![color]!.priceDifferce!;
//   }

//   //check size price
//   final size = cart.size;
//   if (size != null && product.size != null) {
//     price += product.size![size]!;
//   }

//   return price;
// }
