import 'package:custom_utils/spacing_utils.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/app/core/global_widgets/cached_image.dart';
import 'package:shopping_app/app/core/theme/sizing_theme.dart';
import 'package:shopping_app/app/core/utils/helper.dart';
import 'package:shopping_app/app/core/utils/mixins/routes_mixin.dart';
import 'package:shopping_app/app/core/values/strings.dart';
import 'package:shopping_app/app/data/models/product_model.dart';
import 'package:velocity_x/velocity_x.dart';
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
        .onTap(onTap ?? () => onProductTap(product))
        .p8()
        .box
        .color(Vx.gray50)
        .withRounded(value: Sizing.radiusL)
        .make();
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
              _ProductPrice(
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
          .trimText(15)
          .text
          .capitalize
          .fontWeight(FontWeight.w500)
          .size(19)
          .make(),
    );
  }
}

class _ProductPrice extends StatelessWidget {
  final int? price;

  const _ProductPrice({
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
