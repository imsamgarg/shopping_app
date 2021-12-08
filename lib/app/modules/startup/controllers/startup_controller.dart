import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:shopping_app/app/core/utils/mixins/services_mixin.dart';
import 'package:shopping_app/app/modules/startup/views/welcome_view.dart';
import 'package:shopping_app/app/routes/app_pages.dart';

class StartupController extends GetxController with ServicesMixin {
  @override
  void onReady() {
    super.onReady();
    checkForUser();
  }

  void checkForUser() async {
    await Firebase.initializeApp();
    await linkService.saveInitialLink();
    if (await userService.isUserSignedIn()) {
      Get.offAllNamed(Routes.HOME);
    } else {
      Get.to(() => WelcomeView(), routeName: "Welcome Screen");
    }
  }

  void onNextTap() {
    Get.toNamed(Routes.AUTH);
  }
}
