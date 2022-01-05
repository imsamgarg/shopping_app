import 'package:get/get.dart';
import 'package:shopping_app/app/core/utils/mixins/routes_mixin.dart';
import 'package:shopping_app/app/core/utils/mixins/services_mixin.dart';
import 'package:shopping_app/app/data/models/cart_model.dart';
import 'package:shopping_app/app/modules/product/controllers/product_controller.dart';

import 'options_controller.dart';

class ProductOpController extends GetxController
    with ServicesMixin, RoutesMixin {
  late final optionsController = Get.find<OptionsController>();
  late final productController = Get.find<ProductController>();

  late final product = productController.product;

  bool isAddToCartLoading = false;
  final String addToCartButtonId = "add_to_cart";

  late bool isProductLiked = userService.isProductFavourite(product.id!);
  final String isProductLikedId = "isProductLikedId";

  void onAddToCart() async {
    final cartModel = createModel();
    toggleCartButtonLoading(true);

    await cartService.addToCart(cartModel);

    toggleCartButtonLoading(false);
  }

  void toggleCartButtonLoading(bool value) {
    isAddToCartLoading = value;
    update([addToCartButtonId]);
  }

  //* Done!!
  void onBuyNow() {
    final cartModel = createModel();

    final checkoutModel = cartService.createCheckoutModel([cartModel]);

    onCheckoutTap(checkoutModel);
  }

  CartModel createModel() {
    final color = optionsController.color;
    final size = optionsController.size;
    return CartModel(
      color: color,
      size: size,
      product: productController.product,
    );
  }

  void onLikeTap() async {
    String id = product.id!;
    isProductLiked = await userService.toggleFavourite(id, product: product);

    update([isProductLikedId]);
  }
}
