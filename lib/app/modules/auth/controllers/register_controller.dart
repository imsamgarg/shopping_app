import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/app/core/utils/helper.dart';
import 'package:shopping_app/app/core/utils/mixins/error_handling_mixin.dart';
import 'package:shopping_app/app/core/utils/mixins/routes_mixin.dart';
import 'package:shopping_app/app/core/utils/mixins/services_mixin.dart';
import 'package:shopping_app/app/core/utils/mixins/validator_mixin.dart';
import 'package:shopping_app/app/routes/app_pages.dart';

class RegisterController extends GetxController
    with RoutesMixin, ServicesMixin, ErrorHandlingMixin, ValidatorMixin {
  late final GlobalKey<FormState> formKey = GlobalKey();
  late final nameController = TextEditingController();
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

  @override
  void onRegisterTap() {
    if (!formKey.currentState!.validate()) return;
    handleAuthError(_tryRegister, onFinally: () => toggleLoading(false));
  }

  Future _tryRegister() async {
    toggleLoading(true);
    final email = emailController.text;
    final pass = passController.text;
    final name = nameController.text;
    await authService.registerWithEmail(email, pass, name: name);
    Get.offAllNamed(Routes.HOME);
    successSnackbar("Account Created Successfully");
  }

  void toggleLoading(bool value) {
    isButtonLoading = value;
    update([buttonId]);
  }
}
