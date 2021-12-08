import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/app/core/theme/color_theme.dart';
import 'package:shopping_app/app/core/theme/sizing_theme.dart';
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
