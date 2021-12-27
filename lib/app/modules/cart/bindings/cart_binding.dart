import 'package:get/get.dart';

import 'package:shopping_app/app/modules/cart/controllers/cart_product_controller.dart';

import '../controllers/cart_controller.dart';

class CartBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CartProductController>(
      () => CartProductController(),
    );
    Get.lazyPut<CartController>(
      () => CartController(),
    );
  }
}
