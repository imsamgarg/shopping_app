import 'package:get/get.dart';
import 'package:shopping_app/app/core/utils/mixins/error_handling_mixin.dart';
import 'package:shopping_app/app/core/utils/mixins/services_mixin.dart';
import 'package:shopping_app/app/routes/app_pages.dart';

class GoogleAuthController extends GetxController
    with ServicesMixin, ErrorHandlingMixin {
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
    await authService.signInWithGoogle();
    Get.offAllNamed(Routes.HOME);
  }

  void _tryAgain() {
    isTryAgainButtonVisible = true;
    update([buttonId]);
  }
}
