import 'package:get/get.dart';
import 'package:shopping_app/app/data/services/user_service.dart';

import '../controllers/startup_controller.dart';

class StartupBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(UserService());
    Get.lazyPut<StartupController>(
      () => StartupController(),
    );
  }
}
