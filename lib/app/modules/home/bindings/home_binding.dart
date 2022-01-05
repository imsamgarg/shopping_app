import 'package:get/get.dart';
import 'package:shopping_app/app/data/services/address_service.dart';

import 'package:shopping_app/app/data/services/cart_service.dart';
import 'package:shopping_app/app/data/services/config_service.dart';
import 'package:shopping_app/app/data/services/favourties_service.dart';
import 'package:shopping_app/app/data/services/products_service.dart';
import 'package:shopping_app/app/data/services/storage_service.dart';
import 'package:shopping_app/app/data/services/user_service.dart';
import 'package:shopping_app/app/modules/home/controllers/favourite_controller.dart';
import 'package:shopping_app/app/modules/home/controllers/popular_products_controller.dart';
import 'package:shopping_app/app/modules/home/controllers/profile_auth_controller.dart';
import 'package:shopping_app/app/modules/home/controllers/profile_controller.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    //services
    Get.lazyPut<CartService>(() => CartService());
    Get.lazyPut<StorageService>(() => StorageService());
    Get.lazyPut<FavouriteService>(() => FavouriteService());
    Get.lazyPut<AddressService>(() => AddressService());

    Get.put<UserService>(UserService());
    Get.put<ProductsService>(ProductsService());
    Get.put<ConfigService>(ConfigService());

    //controllers

    //home_controllers
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<PopularProductsController>(() => PopularProductsController());

    //profile_controllers
    Get.lazyPut<ProfileController>(() => ProfileController());
    Get.lazyPut<ProfileAuthController>(() => ProfileAuthController());

    //favourite_ontrollers
    Get.lazyPut<FavouriteController>(() => FavouriteController());
  }
}
