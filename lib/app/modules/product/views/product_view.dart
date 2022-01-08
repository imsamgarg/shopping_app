import 'package:flutter/material.dart';

import 'package:custom_utils/spacing_utils.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopping_app/app/core/global_widgets/choice_chip.dart';
import 'package:shopping_app/app/core/global_widgets/stepper.dart';
import 'package:shopping_app/app/core/utils/helper.dart';
import 'package:shopping_app/app/modules/product/controllers/image_controller.dart';
import 'package:shopping_app/app/modules/product/controllers/product_op_controller.dart';
import 'package:shopping_app/app/modules/product/controllers/options_controller.dart';
import 'package:shopping_app/app/modules/product/controllers/share_controller.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:shopping_app/app/core/global_widgets/buttons.dart';
import 'package:shopping_app/app/core/global_widgets/cached_image.dart';
import 'package:shopping_app/app/core/global_widgets/future_builder.dart';
import 'package:shopping_app/app/core/global_widgets/widgets.dart';
import 'package:shopping_app/app/core/values/strings.dart';

import '../../../core/utils/extensions.dart';
import '../controllers/product_controller.dart';

class ProductView extends GetView<ProductController> {
  @override
  Widget build(BuildContext context) {
    return AppFutureBuilder(
      future: controller.instance,
      builder: (snapshot) {
        return Theme(
          data: Theme.of(context).copyWith(
            textTheme: GoogleFonts.varelaRoundTextTheme(),
          ),
          child: Scaffold(
            bottomNavigationBar: Container(
              height: 70,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _BuyNow(),
                  horSpacing16,
                  const _AddToCart(),
                  horSpacing16,
                  CartIcon(
                    color: Vx.white,
                    backgroundColor: primaryColor(context),
                  ),
                ],
              ).px16().paddingOnly(top: 10, bottom: 10),
            ),
            body: const _Body(),
          ),
        );
      },
    );
  }
}

class _Body extends GetView<OptionsController> {
  const _Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          automaticallyImplyLeading: false,
          leading: const _ShareProduct(),
          expandedHeight: 400,
          actions: const [
            _LikeProduct(),
          ],
          flexibleSpace: FlexibleSpaceBar(
            background: _ImageCorousal(),
          ),
        ),
        verSliverSpacing12,
        const _Header(),
        if (controller.sizeOptions != null) const _SelectSize(),
        if (controller.colorOptions != null) const _SelectColor(),
        const _Description(),
        const _DeliveryCharges(),
      ],
    );
  }
}

class _Description extends GetView<ProductController> {
  const _Description();

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: _CustomPadding(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Divider(),
            verSpacing12,
            const _SubHeading("Description"),
            verSpacing20,
            controller.description.text.capitalize
                .color(Colors.grey[600]!)
                .make(),
          ],
        ),
      ),
    );
  }
}

class _ShareProduct extends GetView<ShareController> {
  const _ShareProduct();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: MaterialButton(
        color: Vx.white,
        padding: EdgeInsets.zero,
        shape: const CircleBorder(),
        onPressed: controller.onShareTap,
        child: GetBuilder<ShareController>(
          init: controller,
          builder: (_) {
            if (controller.isButtonLoading) {
              return const Padding(
                padding: EdgeInsets.all(8.0),
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Vx.blue500,
                ),
              );
            }
            return const Icon(
              Icons.share_rounded,
              color: Vx.blue500,
            );
          },
        ),
      ),
    );
  }
}

class _BuyNow extends GetView<ProductOpController> {
  const _BuyNow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AppOutlinedButton(
        onTap: controller.onBuyNow,
        padding: const EdgeInsets.all(16),
        child: ("Buy Now").text.size(14).bold.make(),
      ),
    );
  }
}

class _LikeProduct extends GetView<ProductOpController> {
  const _LikeProduct({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: SizedBox(
        height: 40,
        width: 40,
        child: MaterialButton(
          color: Vx.white,
          padding: EdgeInsets.zero,
          shape: const CircleBorder(),
          onPressed: controller.onLikeTap,
          child: GetBuilder<ProductOpController>(
            init: controller,
            id: controller.isProductLikedId,
            builder: (_) {
              late Widget likedIcon;
              late Widget notLikedIcon;
              if (controller.isProductLiked) {
                likedIcon = const Icon(
                  Icons.favorite_rounded,
                  size: 30,
                  color: Vx.red500,
                  key: ValueKey("yes"),
                );
              } else {
                notLikedIcon = const Icon(
                  Icons.favorite_outline_rounded,
                  key: ValueKey("no"),
                );
              }
              return AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                switchInCurve: Curves.easeInOut,
                child: controller.isProductLiked ? likedIcon : notLikedIcon,
                transitionBuilder: (child, animation) {
                  return ScaleTransition(
                    scale: animation,
                    child: child,
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

class _ImageCorousal extends GetView<ProductImageController> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _ImagesView(),
        Obx(
          () {
            if (!controller.showLeftSwipeButton) return kEmptyWidget;
            return _SwipeButton(
              alignment: Alignment.centerLeft,
              icon: Icons.keyboard_arrow_left_rounded,
              onTap: controller.onLeftArrowPress,
              padding: const EdgeInsets.only(left: 8),
            );
          },
        ),
        Obx(
          () {
            if (!controller.showRightSwipeButton) return kEmptyWidget;

            return _SwipeButton(
              alignment: Alignment.centerRight,
              icon: Icons.keyboard_arrow_right_rounded,
              onTap: controller.onRightArrowPress,
              padding: const EdgeInsets.only(right: 8),
            );
          },
        ),
      ],
    );
  }
}

class _ImagesView extends GetView<ProductImageController> {
  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      physics: const NeverScrollableScrollPhysics(),
      controller: controller.pageController,
      itemBuilder: (context, index) {
        final image = controller.images[index]!;

        final child = Hero(
          tag: image,
          child: CachedImage(
            url: image,
          ).onTap(() => controller.onImageTap(image)),
        );

        if (index != controller.imageLength - 1) return child;

        return GetBuilder<ProductImageController>(
          init: controller,
          id: controller.lastImageWidgetId,
          builder: (_) {
            final image = controller.images[index]!;
            return Hero(
              tag: image,
              child: CachedImage(
                url: image,
              ).onTap(() => controller.onImageTap(image)),
            );
          },
        );
      },
      itemCount: controller.imageLength,
    );
  }
}

class _SwipeButton extends StatelessWidget {
  final Alignment alignment;
  final EdgeInsets padding;
  final IconData icon;
  final VoidCallback onTap;

  const _SwipeButton({
    Key? key,
    required this.alignment,
    required this.padding,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Padding(
        padding: padding,
        child: SizedBox(
          width: 40,
          height: 40,
          child: MaterialButton(
            elevation: 0,
            padding: EdgeInsets.zero,
            color: Colors.black.withOpacity(0.1),
            shape: const CircleBorder(),
            onPressed: onTap,
            child: Icon(
              icon,
              size: 30,
              color: Vx.white,
            ),
          ),
        ),
      ),
    );
  }
}

class _SelectSize extends GetView<OptionsController> {
  const _SelectSize({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: _CustomPadding(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _SubHeading("Select Size"),
            verSpacing12,
            Wrap(
              spacing: 10,
              children: [
                for (final size in controller.sizeOptions!)
                  Obx(
                    () => CustomChip(
                      isSelected: controller.size == size,
                      label: size,
                      onSelected: (_) => controller.changeSize(size),
                    ),
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _SubHeading extends StatelessWidget {
  const _SubHeading(
    this.text, {
    Key? key,
  }) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(child: text.text.bold.size(16).make());
  }
}

class _SelectColor extends GetView<OptionsController> {
  const _SelectColor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: _CustomPadding(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _SubHeading("Select Color"),
            verSpacing12,
            Wrap(
              spacing: 10,
              children: [
                for (final color in controller.colorOptions!)
                  Obx(
                    () => CustomChip(
                      isSelected: controller.color == color,
                      label: color,
                      onSelected: (_) => controller.changeColor(color),
                    ),
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _CustomPadding extends StatelessWidget {
  const _CustomPadding({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10),
      child: child,
    );
  }
}

class _AddToCart extends GetView<ProductOpController> {
  const _AddToCart();

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: controller,
      id: controller.addToCartButtonId,
      builder: (_) {
        if (controller.isAddToCartLoading) {
          return AppTextButton(
            onTap: () {},
            child: const CenterLoading(color: Vx.white, size: 20),
          ).paddingOnly(bottom: 12);
        }
        return Expanded(
          child: AppTextButton(
            padding: const EdgeInsets.all(16),
            onTap: controller.onAddToCart,
            child: ("Add To Cart").text.size(14).bold.make(),
          ),
        );
      },
    );
  }
}

class _Header extends GetView<ProductOpController> {
  const _Header();
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: _CustomPadding(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                _ProductName(),
                _Price(),
              ],
            ),
            verSpacing28,
            Obx(
              () => CustomStepper(
                onDecrementTap: controller.decrementQuantity,
                onIncrementTap: controller.incrementQuantity,
                value: controller.quantity,
              ),
            ),
            verSpacing12,
          ],
        ),
      ),
    );
  }
}

class _ProductName extends GetView<ProductController> {
  const _ProductName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        (controller.name)
            .trim()
            .trimText(15)
            .text
            .fontWeight(FontWeight.w900)
            .textStyle(Theme.of(context).textTheme.headline5!)
            // .size(26)
            // .color(ColorTheme.headerColor)
            .make(),
        verSpacing8,
        (controller.product.subCategory!)
            .text
            .bold
            .size(16)
            .color(Colors.grey.shade500)
            .make(),
      ],
    );
  }
}

class _Price extends GetView<ProductController> {
  const _Price({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        (rsSign.text).color(primaryColor(context)).size(22).make(),
        horSpacing4,
        Obx(() {
          return ("${controller.totalPrice}")
              .text
              .bold
              .color(primaryColor(context))
              // .color(ColorTheme.headerColor.withOpacity(0.9))
              .size(32)
              .make();
        }),
      ],
    );
  }
}

class _DeliveryCharges extends GetView<ProductController> {
  const _DeliveryCharges();

  @override
  Widget build(BuildContext context) {
    var appData = controller.configService.data?.deliveryConfig;

    if (appData == null) {
      return const SliverToBoxAdapter();
    }

    final codCharges = "$rsSign${appData.codCharges}";
    final codFreeOn = "$rsSign${appData.codFreeOn}";

    final prepaidCharges = "$rsSign${appData.razorPayCharges}";
    final prepaidFreeOn = "$rsSign${appData.razorPayFreeOn}";

    final cod = "COD : $codCharges  For Orders Less Then $codFreeOn";
    final prepaid =
        "Online Payment : $prepaidCharges  For Orders Less Then $prepaidFreeOn";

    Widget _textStyle(String text) {
      return text.text.make();
    }

    return SliverToBoxAdapter(
      child: _CustomPadding(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Divider(),
            verSpacing12,
            const _SubHeading("Delivery / Return"),
            verSpacing12,
            _textStyle(cod),
            _textStyle(prepaid),
          ],
        ),
      ),
    );
  }
}
