import 'package:get/get.dart';

import 'package:shopping_app/app/modules/product_list/controllers/filter_controller.dart';
import 'package:shopping_app/app/modules/product_list/controllers/products_list_controller.dart';

class ProductListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductsListController>(
      () => ProductsListController(),
    );
    Get.lazyPut<FilterController>(
      () => FilterController(),
    );
  }
}
