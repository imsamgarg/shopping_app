import 'package:flutter/cupertino.dart';

import 'package:get/get.dart';

import 'package:shopping_app/app/core/utils/helper.dart';
import 'package:shopping_app/app/core/utils/mixins/routes_mixin.dart';
import 'package:shopping_app/app/core/utils/mixins/services_mixin.dart';
import 'package:shopping_app/app/core/values/values.dart';
import 'package:shopping_app/app/data/models/cart_model.dart';
import 'package:shopping_app/app/modules/cart/controllers/cart_product_controller.dart';

import '../../../routes/app_pages.dart';

class CartController extends GetxController with ServicesMixin, RoutesMixin {
  late final instance = _getCartProducts();
  late final List<CartModel> cartItems = [];

  final invalidCartMessage = "Some products are not available";

  late final cartProductsController = Get.find<CartProductController>();

  late final RxInt _finalPrice;
  int get finalPrice => _finalPrice.value;
  set finalPrice(value) => _finalPrice.value = value;

  late final _isCartEmpty = true.obs;
  bool get isCartEmpty => _isCartEmpty.value;
  set isCartEmpty(value) => _isCartEmpty.value = value;

  Future<bool> _getCartProducts() async {
    await cartService.initService();
    await cartService.getCartProducts();

    convertCartMapToList();
    listenToPrice();
    return true;
  }

  void listenToPrice() {
    _finalPrice = calculateTotalPrice().obs;
    isCartEmpty = cartItems.isEmpty;
    _finalPrice.listen((p0) => isCartEmpty = cartItems.isEmpty);
  }

  int calculateTotalPrice() {
    var price = 0;
    for (final item in cartItems) {
      price += item.fullPrice! * item.quantity;
    }
    return price;
  }

  void removeFromCart(BuildContext context, int index, Widget child) async {
    //remove from server
    await cartService.removeFromCart(cartItems[index]);
    //remove from list
    cartItems.removeAt(index);

    //remove product card
    AnimatedList.of(context).removeItem(
      index,
      (_, animation) => SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(-1, 0),
          end: const Offset(0, 0),
        ).animate(animation),
        child: child,
      ),
      duration: const Duration(milliseconds: 700),
    );

    //remove price subscription
    cartProductsController.removeProductDetail(index);

    updateTotalPrice();
  }

  void convertCartMapToList() {
    for (final cartItem in cartService.cartMap.entries) {
      cartItems.add(cartItem.value);
    }
  }

  void updateTotalPrice() {
    finalPrice = calculateTotalPrice();
  }

  void onPlaceOrder() {
    final isValid = validateCartItems();

    //dont do anything if cart is not valid
    if (!isValid) return errorSnackbar(invalidCartMessage);

    final checkoutModel = cartService.createCheckoutModel(
      cartItems,
      shouldCalculatePrice: false,
    );

    //goto checkout view
    onCheckoutTap(checkoutModel);
  }

  bool validateCartItems() {
    for (var index = 0; index < cartItems.length; index++) {
      final availablity = cartProductsController.checkAvailability(index);
      if (availablity != ProductAvailability.available) {
        return false;
      }
    }

    //all clear
    return true;
  }

  void onHomeScreenTap() {
    Get.until((route) => Get.currentRoute == Routes.HOME);
  }
}
