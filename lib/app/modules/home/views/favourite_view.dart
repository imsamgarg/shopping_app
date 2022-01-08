import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:shopping_app/app/core/global_widgets/future_builder.dart';
import 'package:shopping_app/app/core/global_widgets/product_card.dart';
import 'package:shopping_app/app/core/global_widgets/widgets.dart';
import 'package:shopping_app/app/core/theme/sizing_theme.dart';
import 'package:shopping_app/app/core/utils/helper.dart';
import 'package:shopping_app/app/core/values/values.dart';

import 'package:shopping_app/app/data/models/product_model.dart';
import 'package:shopping_app/app/modules/home/controllers/favourite_controller.dart';

class FavouriteView extends GetView<FavouriteController> {
  @override
  Widget build(BuildContext context) {
    return AppFutureBuilder(
        future: controller.instance,
        builder: (_) {
          return Scaffold(
            appBar: AppBar(
              leading: MaterialButton(
                onPressed: controller.onBackPress,
                child: Icon(
                  Icons.arrow_back_rounded,
                  color: primaryColor(context),
                ),
              ),
              actions: [
                CartIcon(
                  color: primaryColor(context),
                )
              ],
              title: const Text("Favourites"),
            ),
            body: Padding(
              padding: Sizing.sidePadding,
              child: PagedGridView<int, ProductModel>(
                pagingController: controller.pagingController,
                builderDelegate: PagedChildBuilderDelegate(
                  itemBuilder: (_, item, i) {
                    return ProductCard(product: item);
                  },
                ),
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: kProductWidth,
                  mainAxisSpacing: 10,
                  mainAxisExtent: kProductHeight,
                  crossAxisSpacing: 10,
                ),
              ),
            ),
          );
        });
  }
}
