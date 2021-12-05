import 'package:get/get.dart';

import 'package:shopping_app/app/modules/auth/controllers/google_auth_controller.dart';
import 'package:shopping_app/app/modules/auth/controllers/login_controller.dart';
import 'package:shopping_app/app/modules/auth/controllers/register_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GoogleAuthController>(
      () => GoogleAuthController(),
    );
    Get.lazyPut<RegisterController>(
      () => RegisterController(),
    );
    Get.lazyPut<LoginController>(
      () => LoginController(),
    );
  }
}
