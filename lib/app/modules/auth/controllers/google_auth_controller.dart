import 'package:get/get.dart';
import 'package:shopping_app/app/core/utils/helper.dart';
import 'package:shopping_app/app/core/utils/mixins.dart';
import 'package:shopping_app/app/routes/app_pages.dart';

class GoogleAuthController extends GetxController with AuthMixin {
  final String buttonId = "button";

  bool isTryAgainButtonVisible = false;

  @override
  void onReady() {
    super.onReady();
    onLoginWithGoogle();
  }

  void onLoginWithGoogle() {
    handleAuthError(_login, onError: _tryAgain);
  }

  Future _login() async {
    await service.signInWithGoogle();
    Get.offAllNamed(Routes.HOME);
  }

  void _tryAgain() {
    isTryAgainButtonVisible = true;
    update([buttonId]);
  }
}
