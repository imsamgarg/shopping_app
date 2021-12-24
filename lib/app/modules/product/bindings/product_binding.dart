import 'package:get/get.dart';

import 'package:shopping_app/app/modules/product/controllers/image_controller.dart';
import 'package:shopping_app/app/modules/product/controllers/options_controller.dart';
import 'package:shopping_app/app/modules/product/controllers/share_controller.dart';

import '../controllers/product_controller.dart';

class ProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductImageController>(
      () => ProductImageController(),
    );
    Get.lazyPut<OptionsController>(
      () => OptionsController(),
    );
    Get.lazyPut<ProductController>(
      () => ProductController(),
    );
    Get.lazyPut<ShareController>(
      () => ShareController(),
    );
  }
}
