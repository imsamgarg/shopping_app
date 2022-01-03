import 'package:custom_utils/spacing_utils.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:shopping_app/app/core/global_widgets/buttons.dart';
import 'package:shopping_app/app/core/global_widgets/cached_image.dart';
import 'package:shopping_app/app/core/global_widgets/future_builder.dart';
import 'package:shopping_app/app/core/global_widgets/widgets.dart';
import 'package:shopping_app/app/core/theme/sizing_theme.dart';
import 'package:velocity_x/velocity_x.dart';
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
            height: 70,
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
            ).px16(),
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
              _Header(),
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
            child: CenterLoading(color: Vx.white, size: 20),
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

class _Header extends GetView<ProductController> {
  const _Header({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(Sizing.radiusXL),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            controller.name.trim().trimText(15).text.bold.size(24).make(),
            // _Price(),
          ],
        ).p20(),
      ),
    );
  }
}

// class _Price extends GetView<ProductController> {
//   const _Price({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return controller.price.text.make();
//   }
// }
