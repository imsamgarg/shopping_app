import 'package:get/get.dart';

import 'package:shopping_app/app/data/services/cart_service.dart';
import 'package:shopping_app/app/data/services/config_service.dart';
import 'package:shopping_app/app/data/services/products_service.dart';
import 'package:shopping_app/app/data/services/user_service.dart';
import 'package:shopping_app/app/modules/home/controllers/favourite_controller.dart';
import 'package:shopping_app/app/modules/home/controllers/popular_products_controller.dart';
import 'package:shopping_app/app/modules/home/controllers/profile_auth_controller.dart';
import 'package:shopping_app/app/modules/home/controllers/profile_controller.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileAuthController>(
      () => ProfileAuthController(),
    );
    Get.lazyPut<PopularProductsController>(
      () => PopularProductsController(),
    );
    //services
    Get.put<UserService>(UserService());
    Get.put<ProductsService>(ProductsService());
    Get.put<CartService>(CartService());
    Get.put<ConfigService>(ConfigService());

    //controllers
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<FavouriteController>(() => FavouriteController());
    Get.lazyPut<ProfileController>(() => ProfileController());
  }
}
