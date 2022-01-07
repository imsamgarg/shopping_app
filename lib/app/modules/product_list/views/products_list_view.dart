import 'package:flutter/material.dart';

import 'package:custom_utils/log_utils.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:shopping_app/app/core/global_widgets/future_builder.dart';
import 'package:shopping_app/app/core/global_widgets/product_card.dart';
import 'package:shopping_app/app/core/theme/sizing_theme.dart';
import 'package:shopping_app/app/core/values/values.dart';
import 'package:shopping_app/app/data/models/product_model.dart';
import 'package:shopping_app/app/modules/product_list/controllers/filter_controller.dart';
import 'package:shopping_app/app/modules/product_list/controllers/products_list_controller.dart';

class ProductsListView extends GetView<ProductsListController> {
  @override
  Widget build(BuildContext context) {
    customLog(context.width);
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.title),
      ),
      floatingActionButton: _FilterFloatingButton(),
      body: Padding(
        padding: Sizing.sidePadding,
        child: PagedGridView<int, ProductSnapshot>(
          pagingController: controller.pagingController,
          builderDelegate: PagedChildBuilderDelegate(
            itemBuilder: (_, item, i) {
              return ProductCard(product: item.product);
            },
          ),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: productWidth,
            mainAxisSpacing: 10,
            mainAxisExtent: productHeight,
            crossAxisSpacing: 10,
          ),
        ),
      ),
    );
  }
}

class _FilterFloatingButton extends GetView<FilterController> {
  @override
  Widget build(BuildContext context) {
    return AppFutureBuilder(
      future: controller.instance,
      builder: (context) {
        return FloatingActionButton(
          onPressed: controller.onFilterTap,
          child: const Icon(
            Icons.filter_list_rounded,
            size: 30,
            color: Vx.white,
          ),
        );
      },
      loading: FloatingActionButton(
        onPressed: null,
        child: const CircularProgressIndicator(
          color: Vx.white,
          strokeWidth: 3,
        ).scale75(),
      ),
      errorBuilder: (error) {
        return const SizedBox.shrink();
      },
    );
  }
}
