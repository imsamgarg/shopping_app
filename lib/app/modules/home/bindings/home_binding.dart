import 'package:get/get.dart';

import 'package:shopping_app/app/data/services/cart_service.dart';
import 'package:shopping_app/app/data/services/config_service.dart';
import 'package:shopping_app/app/data/services/user_service.dart';
import 'package:shopping_app/app/modules/home/controllers/favourite_controller.dart';
import 'package:shopping_app/app/modules/home/controllers/profile_controller.dart';
import 'package:shopping_app/app/modules/home/controllers/tap_controller.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    //services
    Get.put<UserService>(UserService());
    Get.put<CartService>(CartService());
    Get.put<ConfigService>(ConfigService());

    //controllers
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<FavouriteController>(() => FavouriteController());
    Get.lazyPut<ProfileController>(() => ProfileController());
    Get.lazyPut<TapController>(() => TapController());
  }
}
