import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:shopping_app/app/core/global_widgets/future_builder.dart';
import 'package:shopping_app/app/core/global_widgets/product_card.dart';
import 'package:shopping_app/app/core/global_widgets/stepper.dart';
import 'package:shopping_app/app/core/global_widgets/widgets.dart';
import 'package:shopping_app/app/core/theme/color_theme.dart';
import 'package:shopping_app/app/core/values/assets.dart';
import 'package:shopping_app/app/modules/cart/controllers/cart_product_controller.dart';

import '../controllers/cart_controller.dart';
import 'package:velocity_x/velocity_x.dart';

class CartView extends GetView<CartController> {
  @override
  Widget build(BuildContext context) {
    return AppFutureBuilder(
      future: controller.instance,
      builder: (snapshot) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Your Cart'),
          ),
          bottomNavigationBar: const _BottomBar(),
          body: Obx(
            () {
              // customLog(controller., name: "Controller");
              if (controller.isCartEmpty) {
                return InfoWidget(
                  message: "Your Cart Is Empty",
                  image: Assets.assetsImagesEmptyIcon,
                  buttonMessage: "Home Screen",
                  onTap: controller.onHomeScreenTap,
                );
              }
              return AnimatedList(
                initialItemCount: controller.cartItems.length,
                itemBuilder: (context, index, animation) {
                  final product = controller.cartItems[index].product!;
                  return Product(
                    index: index,
                    key: ValueKey(product.id ?? ""),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}

class Product extends GetView<CartProductController> {
  const Product({required this.index, Key? key}) : super(key: key);
  final int index;
  @override
  Widget build(BuildContext context) {
    final cartItem = controller.cartItems[index];
    final product = cartItem.product!;
    final availability = controller.checkAvailability(index);

    final child = CartItem(
      img: product.img![0],
      productName: product.name!,
      productPrice: _ProductPrice(controller: controller, index: index),
      onDeleteTap: () {},
      availability: availability,
      stepper: StepperWidget(controller: controller, index: index),
    );

    final color = cartItem.color;
    final size = cartItem.size;
    String extra = "";

    if (color != null) {
      extra = "Color : $color  ";
    }
    if (size != null) {
      extra = "$extra Size : $size ";
    }

    return CartItem(
      img: product.img![0],
      productName: product.name!,
      productPrice: _ProductPrice(controller: controller, index: index),
      onDeleteTap: () => controller.cartController.removeFromCart(
        context,
        index,
        child,
      ),
      extra: extra.isNotEmpty ? extra : null,
      availability: availability,
      stepper: StepperWidget(
        controller: controller,
        index: index,
      ),
    );
  }
}

class StepperWidget extends StatelessWidget {
  const StepperWidget({
    Key? key,
    required this.controller,
    required this.index,
  }) : super(key: key);

  final CartProductController controller;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        final productDetailRx = controller.productDetailList[index];
        final productDetail = productDetailRx.value;

        return CustomStepper(
          onDecrementTap: () => controller.decrementQuantity(index),
          onIncrementTap: () => controller.incrementQuantity(index),
          value: productDetail.quantity,
        );
      },
    );
  }
}

class _ProductPrice extends StatelessWidget {
  const _ProductPrice({
    Key? key,
    required this.controller,
    required this.index,
  }) : super(key: key);

  final CartProductController controller;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        final productDetailRx = controller.productDetailList[index];
        final productDetail = productDetailRx.value;

        return ProductPrice(price: productDetail.price);
      },
    );
  }
}

class _BottomBar extends GetView<CartController> {
  const _BottomBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (controller.isCartEmpty) return kEmptyWidget;
        return BottomAppBar(
          child: SizedBox(
            height: 80,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(() => Price(price: controller.finalPrice)),
                    const _PlaceOrder(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _PlaceOrder extends GetView<CartController> {
  const _PlaceOrder({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Center(
        child: "Place Order"
            .text
            .bold
            .white
            .make()
            .box
            .padding(const EdgeInsets.symmetric(horizontal: 24, vertical: 16))
            .roundedLg
            .color(ColorTheme.primaryColor)
            .make()
            .onTap(controller.onPlaceOrder),
      ),
    );
  }
}
