import 'package:flutter/material.dart';

import 'package:custom_utils/spacing_utils.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
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
        return Scaffold(
          bottomNavigationBar: Container(
            height: 80,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: AppOutlinedButton(
                    onTap: controller.onBuyNow,
                    child: ("Buy Now").text.size(16).bold.make(),
                  ),
                ),
                horSpacing16,
                _AddToCart(),
              ],
            ).px16().paddingOnly(top: 12),
          ),
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 400,
                flexibleSpace: FlexibleSpaceBar(
                  background: PageView.builder(
                    itemBuilder: (context, index) {
                      return CachedImage(
                        url: controller.images![index],
                      );
                    },
                    itemCount: controller.images!.length,
                  ),
                ),
              ),
              const _Header(),
            ],
          ),
        );
      },
    );
  }
}

class _AddToCart extends GetView<ProductController> {
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
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(Sizing.radiusXL),
          ),
        ),
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
            verSpacing32,
            const _Quantity(),
          ],
        ).p32(),
      ),
    );
  }
}

const _kButtonWidth = 50.0;
const _kButtonHeight = 40.0;

class _Quantity extends GetView<OptionsController> {
  const _Quantity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: const RoundedRectangleBorder(
        borderRadius: Sizing.borderRadiusS,
        side: BorderSide(
          width: 0.3,
          color: Colors.grey,
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
              return "${controller.quantity}"
                  .text
                  .bold
                  .size(22)
                  .textStyle(GoogleFonts.varelaRound())
                  .make();
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
      child: Icon(icon),
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
        .textStyle(GoogleFonts.varelaRound())
        .bold
        .size(30)
        .color(ColorTheme.headerColor)
        .make();
  }
}

class _Price extends GetView<ProductController> {
  const _Price({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return "$rsSign ${controller.totalPrice}"
        .text
        .bold
        .textStyle(GoogleFonts.varelaRound())
        .color(ColorTheme.headerColor.withOpacity(0.9))
        .size(24)
        .make();
  }
}
