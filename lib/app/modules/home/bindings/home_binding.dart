import 'package:get/get.dart';

import 'package:shopping_app/app/modules/home/controllers/address_controller.dart';
import 'package:shopping_app/app/modules/home/controllers/favourite_controller.dart';
import 'package:shopping_app/app/modules/home/controllers/profile_controller.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddressController>(
      () => AddressController(),
    );
    Get.lazyPut<FavouriteController>(
      () => FavouriteController(),
    );
    Get.lazyPut<ProfileController>(
      () => ProfileController(),
    );
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
  }
}
