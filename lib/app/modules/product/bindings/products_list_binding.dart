import 'package:get/get.dart';
import 'package:shopping_app/app/modules/product/controllers/products_list_controller.dart';
import 'package:shopping_app/app/modules/product/controllers/filter_controller.dart';

class ProductsListBinding extends Bindings {
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
