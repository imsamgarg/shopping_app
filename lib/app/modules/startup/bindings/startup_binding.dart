import 'package:get/get.dart';

import 'package:shopping_app/app/data/services/auth_service.dart';
import 'package:shopping_app/app/data/services/dynamic_link_service.dart';
import 'package:shopping_app/app/data/services/user_service.dart';

import '../controllers/startup_controller.dart';

class StartupBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(DynamicLinkService());
    Get.put(UserService());
    Get.put(AuthService());
    Get.put<StartupController>(StartupController());
  }
}
