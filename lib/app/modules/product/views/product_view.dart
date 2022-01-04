import 'package:flutter/material.dart';

import 'package:custom_utils/spacing_utils.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopping_app/app/core/global_widgets/choice_chip.dart';
import 'package:shopping_app/app/modules/product/controllers/image_controller.dart';
import 'package:shopping_app/app/modules/product/controllers/operations_controller.dart';
import 'package:shopping_app/app/modules/product/controllers/options_controller.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:shopping_app/app/core/global_widgets/buttons.dart';
import 'package:shopping_app/app/core/global_widgets/cached_image.dart';
import 'package:shopping_app/app/core/global_widgets/future_builder.dart';
import 'package:shopping_app/app/core/global_widgets/widgets.dart';
import 'package:shopping_app/app/core/theme/color_theme.dart';
import 'package:shopping_app/app/core/theme/sizing_theme.dart';
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
              height: 80,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  _BuyNow(),
                  horSpacing16,
                  _AddToCart(),
                ],
              ).px16().paddingOnly(top: 12),
            ),
            body: CustomScrollView(
              slivers: [
                SliverAppBar(
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
                const _SelectSize(),
                const _SelectColor(),
                const _SelectColor(),
                const _SelectColor(),
                const _SelectColor(),
                const _SelectColor(),
                const _SelectColor(),
                const _SelectColor(),
                const _SelectColor(),
                const _SelectColor(),
                const _SelectColor(),
                const _SelectColor(),
              ],
            ),
          ),
        );
      },
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
        child: ("Buy Now").text.size(16).bold.make(),
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
          onPressed: () {},
          child: const Icon(
            Icons.favorite_rounded,
            color: Vx.red500,
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
        _SwipeButton(
          alignment: Alignment.centerLeft,
          icon: Icons.keyboard_arrow_left_rounded,
          onTap: controller.onLeftArrowPress,
          padding: const EdgeInsets.only(left: 8),
        ),
        _SwipeButton(
          alignment: Alignment.centerRight,
          icon: Icons.keyboard_arrow_right_rounded,
          onTap: controller.onRightArrowPress,
          padding: const EdgeInsets.only(right: 8),
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
        final child = CachedImage(
          borderRadius: BorderRadius.zero,
          url: controller.images[index]!,
        );

        if (index != controller.imageLength - 1) return child;

        return GetBuilder<ProductImageController>(
          init: controller,
          id: controller.lastImageWidgetId,
          builder: (_) {
            return CachedImage(
              borderRadius: BorderRadius.zero,
              url: controller.images[index]!,
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
            padding: EdgeInsets.zero,
            // color: Colors.black.withOpacity(0.1),
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
            "Select Size".text.bold.size(16).make(),
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

class _SelectColor extends GetView<OptionsController> {
  const _SelectColor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: _CustomPadding(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            "Select Color".text.bold.size(16).make(),
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
            onTap: controller.onAddToCart,
            child: ("Add To Cart").text.size(16).bold.make(),
          ),
        );
      },
    );
  }
}

class _Header extends StatelessWidget {
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
            verSpacing20,
            const _Quantity(),
            verSpacing12,
          ],
        ),
      ),
    );
  }
}

const _kButtonWidth = 32.0;
const _kButtonHeight = 32.0;

class _Quantity extends GetView<OptionsController> {
  const _Quantity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: Sizing.borderRadiusS,
        side: BorderSide(
          width: 1,
          color: Colors.grey.shade200,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _StepperButton(
            icon: Icons.remove,
            onTap: controller.decrementQuantity,
          ),
          horSpacing10,
          Obx(
            () {
              return "${controller.quantity}".text.bold.size(18).make();
            },
          ),
          horSpacing10,
          _StepperButton(
            icon: Icons.add,
            onTap: controller.incrementQuantity,
          ),
        ],
      ),
    );
  }
}

class _StepperButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _StepperButton({
    Key? key,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: EdgeInsets.zero,
      shape: Sizing.cardShape,
      onPressed: onTap,
      child: Icon(icon, size: 20),
    ).box.size(_kButtonWidth, _kButtonHeight).make();
  }
}

class _ProductName extends GetView<ProductController> {
  const _ProductName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return controller.name
        .trim()
        .trimText(15)
        .text
        .extraBold
        .textStyle(GoogleFonts.nunitoSans())
        .size(26)
        .color(ColorTheme.headerColor)
        .make();
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
        rsSign.text.size(22).make(),
        horSpacing4,
        Obx(() {
          return "${controller.totalPrice}"
              .text
              .bold
              .color(ColorTheme.headerColor.withOpacity(0.9))
              .size(32)
              .make();
        }),
      ],
    );
  }
}
