import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:shopping_app/app/data/services/user_service.dart';
import 'package:shopping_app/app/modules/startup/views/welcome_view.dart';
import 'package:shopping_app/app/routes/app_pages.dart';

class StartupController extends GetxController {
  @override
  void onReady() {
    super.onReady();
    checkForUser();
  }

  void checkForUser() async {
    await Firebase.initializeApp();
    final service = Get.find<UserService>();
    if (await service.isUserSignedIn()) {
      Get.offAllNamed(Routes.HOME);
    } else {
      Get.to(() => WelcomeView(), routeName: "Welcome Screen");
    }
  }

  void onNextTap() {
    Get.toNamed(Routes.AUTH);
  }
}
