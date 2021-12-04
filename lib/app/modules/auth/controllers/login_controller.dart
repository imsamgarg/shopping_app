import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  late final GlobalKey formKey = GlobalKey<FormState>();

  late final emailController = TextEditingController();
  late final passController = TextEditingController();

  bool isLoading = false;

  final String buttonId = "button";

  void onLoginTap() {}

  void onRegisterTap() {}

  void onGoogleTap() {}

  void onCallTap() {}

  void onForgotPasswordTap() {}
}
