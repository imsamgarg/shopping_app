import 'package:get/get.dart';

import '../controllers/address_list_controller.dart';

class AddressBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddressListController>(
      () => AddressListController(),
    );
  }
}
