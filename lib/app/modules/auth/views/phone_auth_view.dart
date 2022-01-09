import 'package:flutter/material.dart';

import 'package:custom_utils/spacing_utils.dart';
import 'package:get/get.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:shopping_app/app/core/values/assets.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:shopping_app/app/core/global_widgets/buttons.dart';
import 'package:shopping_app/app/core/global_widgets/input_fields.dart';
import 'package:shopping_app/app/core/global_widgets/responsive.dart';
import 'package:shopping_app/app/core/theme/sizing_theme.dart';
import 'package:shopping_app/app/core/utils/helper.dart';
import 'package:shopping_app/app/modules/auth/controllers/phone_auth_controller.dart';

class PhoneAuthView extends StatelessWidget {
  final bool link;

  PhoneAuthView({Key? key, this.link = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PhoneAuthController(link));
    final loginHeading = "Your Phone".text.size(35).bold.make();
    final otpHeading = "Enter Otp".text.size(35).bold.make();

    return Scaffold(
      floatingActionButton: Counter(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        child: Form(
          key: controller.formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _HeaderImage(controller: controller),
              verSpacing30,
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  GetBuilder<PhoneAuthController>(
                    init: controller,
                    id: controller.builderId,
                    builder: (_) {
                      if (controller.isOtpSent) {
                        return Hero(
                          key: const ValueKey(1),
                          tag: "heading",
                          child: Material(
                            color: Colors.transparent,
                            child: otpHeading,
                          ),
                        );
                      }
                      return Hero(
                        key: const ValueKey(2),
                        tag: "heading",
                        child: Material(
                          color: Colors.transparent,
                          child: loginHeading,
                        ),
                      );
                    },
                  ),
                  verSpacing30,
                  GetBuilder<PhoneAuthController>(
                    init: controller,
                    id: controller.builderId,
                    builder: (_) {
                      if (!controller.isOtpSent) {
                        return CustomInputField(
                          key: const ValueKey(1),
                          icon: Icons.call,
                          hintText: "Mobile Number +91",
                          validator: controller.phoneNumberValidator,
                          controller: controller.phoneController,
                          textInputType: const TextInputType.numberWithOptions(
                            decimal: false,
                            signed: false,
                          ),
                        );
                      } else {
                        return _CustomOtpField(controller: controller);
                      }
                    },
                  ),
                  verSpacing30,
                  _Button(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CustomOtpField extends StatelessWidget {
  const _CustomOtpField({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final PhoneAuthController controller;

  @override
  Widget build(BuildContext context) {
    final fadedColor = Colors.grey.withOpacity(0.2);

    return PinPut(
      eachFieldHeight: 40,
      eachFieldWidth: 40,
      onSubmit: (_) => controller.onVerifyOtp,
      textInputAction: TextInputAction.done,
      textStyle: const TextStyle(
        fontSize: 18,
        color: Vx.white,
        fontWeight: FontWeight.bold,
      ),
      selectedFieldDecoration: BoxDecoration(
        shape: BoxShape.circle,
        color: fadedColor,
      ),
      followingFieldDecoration: BoxDecoration(
        color: fadedColor,
        borderRadius: Sizing.borderRadiusXS,
      ),
      submittedFieldDecoration: BoxDecoration(
        color: primaryColor(context),
        borderRadius: Sizing.borderRadiusXL,
        border: Border.all(
          width: 1.5,
          color: primaryColor(context).withOpacity(0.7),
        ),
      ),
      key: const ValueKey(2),
      cursorColor: primaryColor(context),
      validator: controller.otpCodeValidator,
      controller: controller.otpController,
      fieldsCount: 6,
    );
  }
}

class _HeaderImage extends StatelessWidget {
  const _HeaderImage({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final PhoneAuthController controller;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PhoneAuthController>(
      init: controller,
      id: controller.builderId,
      builder: (_) {
        return AnimatedSwitcher(
          switchInCurve: Curves.easeInOut,
          switchOutCurve: Curves.easeOutSine,
          child: (!controller.isOtpSent)
              ? HeaderImage(
                  key: const ValueKey("Phone"),
                  image: Assets.assetsImagesLogin,
                  viewInsets: context.mq.viewInsets.bottom,
                )
              : HeaderImage(
                  key: const ValueKey("Otp"),
                  image: Assets.assetsImagesEnterOtpMain,
                  viewInsets: context.mq.viewInsets.bottom,
                ),
          duration: const Duration(milliseconds: 400),
          transitionBuilder: (child, animation) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(-1, 0),
                end: const Offset(0, 0),
              ).animate(animation),
              child: child,
            );
          },
        );
      },
    );
  }
}

class Counter extends GetView<PhoneAuthController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PhoneAuthController>(
      init: controller,
      id: controller.timerId,
      builder: (controller) {
        return Visibility(
          visible: controller.isOtpSent,
          child: FloatingActionButton(
            onPressed: () {},
            child: Obx(() {
              return "${controller.timer}".text.bold.white.size(18).make();
            }),
          ),
        );
      },
    );
  }
}

class _Button extends GetView<PhoneAuthController> {
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "button",
      child: GetBuilder(
        init: controller,
        id: controller.buttonId,
        builder: (PhoneAuthController controller) {
          final isOtpSent = controller.isOtpSent;
          final text = isOtpSent ? "Verify Otp" : "Send Otp";
          return AppTextButton(
            isLoading: controller.isButtonLoading,
            onTap: controller.isOtpSent
                ? controller.onVerifyOtp
                : controller.onSendOtp,
            child: text.text.size(18).make(),
          );
        },
      ),
    );
  }
}
