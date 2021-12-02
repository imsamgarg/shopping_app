import 'package:custom_utils/log_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/app/core/interfaces.dart';
import 'package:shopping_app/app/core/theme/color_theme.dart';
import 'package:shopping_app/app/core/theme/sizing_theme.dart';
import 'package:shopping_app/app/core/values/strings.dart';
import 'package:velocity_x/velocity_x.dart';

void goBack() {
  Get.back();
}

void successSnackbar(
  String message, [
  int sec = 4,
  SnackPosition snackPosition = SnackPosition.BOTTOM,
]) {
  return customSnackBar(
    message,
    Icon(Icons.check, color: Vx.white),
    ColorTheme.successColor,
    snackPosition: snackPosition,
  );
}

void errorSnackbar(
  String message, [
  int sec = 4,
  SnackPosition snackPosition = SnackPosition.BOTTOM,
]) {
  return customSnackBar(
    message,
    Icon(Icons.cancel_rounded, color: Vx.white),
    ColorTheme.errorColor,
    snackPosition: snackPosition,
  );
}

void customSnackBar(
  String message,
  Icon icon,
  Color bgColor, {
  int sec = 4,
  Color fgColor = Vx.white,
  SnackPosition snackPosition = SnackPosition.BOTTOM,
}) {
  Get.rawSnackbar(
    message: message,
    snackPosition: snackPosition,
    shouldIconPulse: false,
    icon: icon,
    duration: Duration(seconds: sec),
    backgroundColor: bgColor,
    overlayColor: fgColor,
    borderRadius: Sizing.radiusS,
  );
}

Color primaryColor(BuildContext context) {
  return Theme.of(context).primaryColor;
}

String handleFirebaseAuthErrorCodes(String errorCode) {
  String _msg;
  switch (errorCode) {
    case "email-already-in-use":
      _msg = "Email Is Already In Use!! ";
      break;
    case "account-exists-with-different-credential":
      _msg = "User Already Exist On Email/Password Login ";
      break;
    case "user-disabled":
      _msg = "Your Account Has Been Disabled";
      break;
    case "invalid-email":
      _msg = "Email Address Is Invalid";
      break;
    case "weak-password":
      _msg = "Password Is Weak";
      break;
    case "wrong-password":
      _msg = "Wrong Email Or Password";
      break;
    case "user-not-found":
      _msg = "No User Found For This Email";
      break;
    case "invalid-verification-code":
      _msg = "Invalid Otp";
      break;
    case "invalid-verification-id":
      _msg = "Invalid Otp";
      break;
    default:
      _msg = errorMsg;
      break;
  }
  return _msg;
}

Future<T> handleFirebaseAuthError<T>(Future<T> Function() callback) async {
  try {
    return await callback();
  } on FirebaseAuthException catch (e, s) {
    customLog(
      "FirebaseAuthException  Error",
      name: "Error",
      error: e,
      stackTrace: s,
    );
    String _msg = handleFirebaseAuthErrorCodes(e.code);
    throw AuthException(_msg);
  } on Exception catch (e, s) {
    customLog(
      "FirebaseAuthException  Error",
      name: "Error",
      error: e,
      stackTrace: s,
    );
    throw AuthException(errorMsg);
  }
}
