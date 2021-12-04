import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:shopping_app/app/core/utils/helper.dart';
import 'package:shopping_app/app/core/utils/mixins.dart';
import 'package:shopping_app/app/routes/app_pages.dart';

class LoginController extends GetxController with AuthMixin {
  late final GlobalKey<FormState> formKey = GlobalKey();
  late final emailController = TextEditingController();
  late final passController = TextEditingController();

  bool isButtonLoading = false;

  final String buttonId = "button";

  @override
  void onClose() {
    emailController.dispose();
    passController.dispose();
    super.onClose();
  }

  void onLoginTap() {
    if (!formKey.currentState!.validate()) return;
    handleAuthError(_tryLogin, onFinally: () => toggleLoading(false));
  }

  Future _tryLogin() async {
    toggleLoading(true);
    final email = emailController.text;
    final pass = passController.text;
    await service.signInWithEmail(email, pass);
    Get.offAllNamed(Routes.HOME);
    successSnackbar("Welcome !!");
  }

  void onForgotPasswordTap() {
    if (emailController.text.isEmpty || !emailController.text.isEmail) {
      errorSnackbar("Please Enter Valid Email");
      return;
    }
    handleAuthError(_sendResetMail);
  }

  Future _sendResetMail() async {
    final email = emailController.text;
    await service.sendPassResetEmail(email);
    successSnackbar("Password Reset Email Sent!!");
  }

  void toggleLoading(bool value) {
    isButtonLoading = value;
    update([buttonId]);
  }
}
