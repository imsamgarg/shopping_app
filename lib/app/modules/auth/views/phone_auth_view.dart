import 'package:custom_utils/spacing_utils.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:shopping_app/app/core/global_widgets/input_fields.dart';
import 'package:shopping_app/app/core/global_widgets/responsive.dart';
import 'package:shopping_app/app/core/global_widgets/widgets.dart';
import 'package:shopping_app/app/core/theme/sizing_theme.dart';
import 'package:shopping_app/app/core/utils/helper.dart';
import 'package:shopping_app/app/core/utils/mixins.dart';
import 'package:shopping_app/app/core/values/values.dart';
import 'package:shopping_app/app/modules/auth/controllers/phone_auth_controller.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:get/get.dart';

class PhoneAuthView extends StatelessWidget with Validators {
  final bool link;

  PhoneAuthView({Key? key, this.link = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PhoneAuthController(link));
    final loginHeading =
        "Your Phone".text.size(35).fontWeight(FontWeight.bold).make();

    return Scaffold(
      floatingActionButton: Counter(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        child: Form(
          key: controller.formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              HeaderImage(),
              AdaptiveHide(hideOn: ScreenSize.lg, child: verSpacing30),
              verSpacing30,
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Hero(
                    tag: "heading",
                    child: Material(
                      color: Colors.transparent,
                      child: loginHeading,
                    ),
                  ),
                  verSpacing30,
                  GetBuilder<PhoneAuthController>(
                    init: controller,
                    id: controller.inputFieldsId,
                    builder: (_) {
                      if (!controller.isOtpSent) {
                        return CustomInputField(
                          key: ValueKey("1"),
                          icon: Icons.call,
                          hintText: "Mobile Number +91",
                          validator: phoneNumberValidator,
                          controller: controller.phoneController,
                          textInputType: TextInputType.numberWithOptions(
                            decimal: false,
                            signed: false,
                          ),
                        );
                      } else {
                        return SizedBox.shrink();
                      }
                    },
                  ),
                  GetBuilder<PhoneAuthController>(
                    init: controller,
                    id: controller.inputFieldsId,
                    builder: (_) {
                      if (controller.isOtpSent) {
                        return PinPut(
                          key: ValueKey("2"),
                          cursorColor: primaryColor(context),
                          validator: otpCodeValidator,
                          controller: controller.otpController,
                          fieldsCount: 6,
                        );
                      } else {
                        return SizedBox.shrink();
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
              return Text(controller.timer.toString());
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
          return TextButton(
            style: TextButton.styleFrom(
              backgroundColor: primaryColor(context),
              padding: const EdgeInsets.all(18),
              shape: Sizing.cardShape,
            ),
            onPressed: controller.isOtpSent
                ? controller.onVerifyOtp
                : controller.onSendOtp,
            child: controller.isButtonLoading
                ? CenterLoading(size: 18)
                : text.text.size(18).make(),
          );
        },
      ),
    );
  }
}
