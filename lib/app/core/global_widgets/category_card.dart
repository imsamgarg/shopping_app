import 'package:custom_utils/spacing_utils.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/app/core/global_widgets/cached_image.dart';
import 'package:shopping_app/app/core/theme/sizing_theme.dart';
import 'package:shopping_app/app/core/utils/mixins/routes_mixin.dart';
import 'package:shopping_app/app/data/models/category_model.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:shopping_app/app/core/utils/extensions.dart';

class SubCategoryCard extends StatelessWidget with RoutesMixin {
  const SubCategoryCard({
    Key? key,
    required this.subCategory,
    this.onTap,
  }) : super(key: key);

  final SubCategory subCategory;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(child: CachedImage(url: subCategory.image!)),
        verSpacing10,
        _CategoryName(pName: subCategory.name),
        verSpacing10,
      ],
    )
        .p8()
        .box
        .color(Vx.gray50)
        .withRounded(value: Sizing.radiusL)
        .make()
        .onTap(onTap ?? () => onSubCategoryTap(subCategory: subCategory));
  }
}

class _CategoryName extends StatelessWidget {
  const _CategoryName({
    Key? key,
    required this.pName,
  }) : super(key: key);

  final String? pName;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: pName!
          .trim()
          .allWordsCapitilize()
          .trimText(15)
          .text
          .bold
          .fontWeight(FontWeight.w500)
          .size(19)
          .make(),
    );
  }
}
