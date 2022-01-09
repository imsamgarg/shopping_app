import 'package:flutter/material.dart';

import 'package:custom_utils/spacing_utils.dart';
import 'package:shopping_app/app/core/values/values.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:shopping_app/app/core/global_widgets/cached_image.dart';
import 'package:shopping_app/app/core/theme/sizing_theme.dart';
import 'package:shopping_app/app/core/utils/helper.dart';
import 'package:shopping_app/app/core/utils/mixins/routes_mixin.dart';
import 'package:shopping_app/app/core/values/strings.dart';
import 'package:shopping_app/app/data/models/product_model.dart';

import '../../core/utils/extensions.dart';

class ProductCard extends StatelessWidget with RoutesMixin {
  const ProductCard({
    Key? key,
    required this.product,
    this.onTap,
  }) : super(key: key);

  final ProductModel product;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(flex: 5, child: CachedImage(url: product.img![0])),
        verSpacing10,
        Expanded(
          flex: 2,
          child: _ProductDetail(
            pName: product.name,
            price: product.price,
            discount: product.discount,
          ),
        ),
      ],
    )
        .p8()
        .box
        .color(Vx.gray50)
        .withRounded(value: Sizing.radiusL)
        .make()
        .onTap(onTap ?? () => onProductTap(product));
  }
}

class _ProductDetail extends StatelessWidget {
  const _ProductDetail({
    Key? key,
    required this.pName,
    required this.price,
    required this.discount,
  }) : super(key: key);

  final String? pName;
  final int? price;
  final int? discount;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _ProductName(pName: pName),
        Expanded(
          flex: 1,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ProductPrice(
                price: price,
              ),
              const SizedBox(
                width: 10,
              ),
              Flexible(
                child: _DiscountText(discount?.toString() ?? ""),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ProductName extends StatelessWidget {
  const _ProductName({
    Key? key,
    required this.pName,
  }) : super(key: key);

  final String? pName;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: pName!
          .trim()
          .allWordsCapitilize()
          .trimText(15)
          .text
          .fontWeight(FontWeight.w500)
          .size(19)
          .make(),
    );
  }
}

class ProductPrice extends StatelessWidget {
  final int? price;

  const ProductPrice({
    Key? key,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: "$rsSign ${price ?? "Error"}".text.semiBold.size(17).make(),
    );
  }
}

class _DiscountText extends StatelessWidget {
  final String discount;

  const _DiscountText(this.discount, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return "$discount% off"
        .toString()
        .text
        .size(14)
        .bold
        .color(primaryColor(context))
        .make()
        .box
        .make();
  }
}

class CartItem extends StatelessWidget {
  final String img;
  final String? extra;
  final String productName;
  final ProductAvailability availability;
  final Widget stepper;
  final Widget productPrice;
  final VoidCallback onDeleteTap;

  const CartItem({
    Key? key,
    required this.img,
    required this.productName,
    this.extra = "",
    required this.availability,
    required this.onDeleteTap,
    required this.stepper,
    required this.productPrice,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isAvailable = availability == ProductAvailability.available;
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: kHorProductWidth,
                child: CachedImage(url: img),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _ProductName(pName: productName),
                    verSpacing10,
                    productPrice,
                    verSpacing10,
                    if (availability == ProductAvailability.available) stepper,
                    verSpacing10,
                    if (extra != null)
                      extra!.text.bold.color(primaryColor(context)).make(),
                  ],
                ),
              )
            ],
          ),
        ),
        if (!isAvailable) const OutOfStockMask(),
        Icon(
          Icons.delete_forever_rounded,
          color: (isAvailable) ? primaryColor(context) : Vx.white,
        )
            .box
            .p8
            .height(45)
            .width(45)
            .alignCenter
            .make()
            .onInkTap(onDeleteTap)
            .material(color: Colors.transparent)
            .objectTopRight(),
      ],
    )
        .p8()
        .box
        .height(kHorProductHeight)
        .color(Vx.gray50)
        .withRounded(value: Sizing.radiusL)
        .make()
        .pSymmetric(h: 16, v: 8);
  }
}

class OutOfStockMask extends StatelessWidget {
  final ProductAvailability? availability;

  const OutOfStockMask({
    Key? key,
    this.availability,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late String message;
    switch (availability) {
      case ProductAvailability.notAvailable:
        message = "Product Is Out Of Stock";
        break;
      case ProductAvailability.colorNotAvailable:
        message = "This Color Is Out Of Stock";
        break;
      case ProductAvailability.sizeNotAvailable:
        message = "This Size Is Out Of Stock";
        break;
      case ProductAvailability.productDeleted:
        message = "This Product Is Not Available";
        break;
      default:
        break;
    }
    return AbsorbPointer(
      absorbing: true,
      child: message.text.white
          .size(17)
          .make()
          .box
          .withRounded(value: 8)
          .alignCenter
          .color(Colors.black.withOpacity(0.5))
          .make(),
    );
  }
}
