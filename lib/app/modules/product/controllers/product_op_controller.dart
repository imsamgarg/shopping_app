import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/app/core/utils/helper.dart';
import 'package:shopping_app/app/core/utils/mixins/routes_mixin.dart';
import 'package:shopping_app/app/core/utils/mixins/services_mixin.dart';
import 'package:shopping_app/app/core/values/values.dart';
import 'package:shopping_app/app/data/models/cart_model.dart';
import 'package:shopping_app/app/modules/product/controllers/product_controller.dart';
import 'package:velocity_x/velocity_x.dart';

import 'options_controller.dart';

class ProductOpController extends GetxController
    with ServicesMixin, RoutesMixin {
  late final optionsController = Get.find<OptionsController>();
  late final productController = Get.find<ProductController>();

  late final product = productController.product;

  bool isAddToCartLoading = false;
  final String addToCartButtonId = "add_to_cart";

  late bool isProductLiked = favouriteService.isProductFavourite(product.id!);
  final String isProductLikedId = "isProductLikedId";

  final _quantity = 1.obs;
  int get quantity => _quantity.value;
  set quantity(value) => _quantity.value = value;

  void incrementQuantity() {
    if (quantity >= kProductMaxQuantity) {
      return;
    }
    ++quantity;
  }

  void decrementQuantity() {
    if (quantity == kProductMinQuantity) {
      return;
    }
    --quantity;
  }

  void onAddToCart() async {
    final cartModel = createModel();
    toggleCartButtonLoading(true);

    final size = cartModel.size;
    final color = cartModel.color;

    final isSizeRequired = productController.product.isSizeRequired ?? false;
    final isColorRequired = productController.product.isColorRequired ?? false;

    if (size == null && isSizeRequired) {
      toggleCartButtonLoading(false);
      return errorSnackbar("Please Select Size");
    }

    if (color == null && isColorRequired) {
      toggleCartButtonLoading(false);
      return errorSnackbar("Please Select Color");
    }

    final alreadyInCart = await cartService.addToCart(cartModel);

    if (!alreadyInCart) {
      customSnackBar(
        "Product Is Already In Cart",
        const Icon(Icons.check, color: Vx.white),
        Vx.yellow600,
        fgColor: Vx.white,
      );
    } else {
      successSnackbar("Product Added To Cart");
    }

// Product Added To Cart
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
      quantity: quantity,
    );
  }

  void onLikeTap() async {
    String id = product.id!;
    final value = await favouriteService.toggleFavourite(id, product: product);

    toggleFavouriteButton(value);
  }

  void toggleFavouriteButton(bool value) {
    isProductLiked = value;

    update([isProductLikedId]);
  }
}
