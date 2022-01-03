import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'package:shopping_app/app/data/models/product_model.dart';
import 'package:shopping_app/app/modules/home/controllers/favourite_controller.dart';

class FavouriteView extends GetView<FavouriteController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PagedListView(
        pagingController: controller.pagingController,
        builderDelegate: PagedChildBuilderDelegate<ProductModel>(
          itemBuilder: (context, item, index) {
            return Container();
          },
        ),
      ),
    );
  }
}
