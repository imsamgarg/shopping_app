import 'dart:async';

import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import 'package:shopping_app/app/core/utils/helper.dart';
import 'package:shopping_app/app/core/utils/mixins/error_handling_mixin.dart';
import 'package:shopping_app/app/core/utils/mixins/routes_mixin.dart';
import 'package:shopping_app/app/core/utils/mixins/services_mixin.dart';
import 'package:shopping_app/app/core/utils/mixins/validator_mixin.dart';
import 'package:shopping_app/app/routes/app_pages.dart';

class PhoneAuthController extends GetxController
    with ServicesMixin, ErrorHandlingMixin, RoutesMixin, ValidatorMixin {
  late String _verificationId;

  PhoneAuthController(this.link);
  final bool link;
  late final GlobalKey<FormState> formKey = GlobalKey();
  late final phoneController = TextEditingController();
  late final otpController = TextEditingController();

  bool isButtonLoading = false;
  bool isOtpSent = false;

  final String buttonId = "button";
  final String timerId = "timer";
  final String builderId = "fields";

  final _timer = 60.obs;
  get timer => _timer.value;
  set timer(value) => _timer.value = value;

  @override
  void onClose() {
    phoneController.dispose();
    otpController.dispose();
    super.onClose();
  }

  Future _verifyOtp(AuthCredential credential) async {
    if (link) {
      await authService.linkWithCreds(credential);
      Get.back();
      successSnackbar("Mobile Successfully Linked", 3);
      return;
    }

    final isNewUser = await authService.loginWithPhone(credential);
    Get.offAllNamed(Routes.HOME);
    if (isNewUser) {
      successSnackbar("Phone Number Authenticated");
    } else {
      successSnackbar("Welcome Back!!");
    }
  }

  _onVerificationCompletion(PhoneAuthCredential credential) {
    otpController.text = credential.smsCode!;
    toggleButtonLoading(true);

    handleAuthError(
      () => _verifyOtp(credential),
      onFinally: () {
        toggleButtonLoading(false);
      },
    );
  }

  _onVerificationFailed(FirebaseAuthException e) {
    String errorMsg = handleFirebaseAuthErrorCodes(e.code);
    errorSnackbar(errorMsg);
    toggleButtonLoading(false);
    isOtpSent = true;
    update([builderId, timerId]);
  }

  void onVerifyOtp() async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: _verificationId,
      smsCode: otpController.text,
    );

    toggleButtonLoading(true);

    handleAuthError(
      () => _verifyOtp(credential),
      onFinally: () {
        toggleButtonLoading(false);
      },
    );
  }

  _onCodeSent(String verificationId, int? resendToken) {
    final timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timer.value > 0) --_timer.value;
    });

    Future.delayed(const Duration(seconds: 62)).then((value) {
      timer.cancel();
    });

    _verificationId = verificationId;
    toggleButtonLoading(false);
    isOtpSent = true;
    update([builderId, timerId]);

    customSnackBar(
      "Otp Sent!! Auto Retrieving Otp in 60 Seconds",
      const Icon(Icons.timer),
      Colors.grey.shade800,
    );
  }

  _onCodeAutoRetrievalTimeout(String verificationId) {
    // errorSnackbar("Auto Detect Timer Expired")
  }

  void onSendOtp() {
    if (!formKey.currentState!.validate()) return;

    toggleButtonLoading(true);
    String phone = phoneController.text;
    phone = "+91$phone";
    authService.initPhoneAuth(
      phoneNumber: phone,
      verificationCompleted: _onVerificationCompletion,
      verificationFailed: _onVerificationFailed,
      codeSent: _onCodeSent,
      codeAutoRetrievalTimeout: _onCodeAutoRetrievalTimeout,
    );
  }

  void toggleButtonLoading(bool value) {
    isButtonLoading = value;
    update([buttonId]);
  }
}
