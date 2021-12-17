import 'package:get/get.dart';

import 'package:shopping_app/app/modules/address/controllers/address_controller.dart';

import '../controllers/address_list_controller.dart';

class AddressBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddressListController>(
      () => AddressListController(),
    );
  }
}
