import 'package:custom_utils/spacing_utils.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:shopping_app/app/core/global_widgets/buttons.dart';
import 'package:shopping_app/app/core/global_widgets/input_fields.dart';
import 'package:shopping_app/app/core/global_widgets/responsive.dart';
import 'package:shopping_app/app/core/global_widgets/widgets.dart';
import 'package:shopping_app/app/core/theme/sizing_theme.dart';
import 'package:shopping_app/app/core/utils/helper.dart';
import 'package:shopping_app/app/core/utils/mixins.dart';
import 'package:shopping_app/app/core/values/values.dart';
import 'package:velocity_x/velocity_x.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> with Validators {
  final loginHeading = "Login".text.size(35).fontWeight(FontWeight.bold).make();

  @override
  Widget build(BuildContext context) {
    final _height = context.screenHeight;
    final _bottomInsets = context.mq.viewInsets.bottom;
    final isSmallScreen = _height - _bottomInsets < 550;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 30,
          vertical: isSmallScreen ? 0 : 30,
        ),
        child: Form(
          key: controller.formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              HeaderImage(),
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
                  isSmallScreen ? verSpacing10 : verSpacing20,
                  CustomInputField(
                    icon: Icons.alternate_email_outlined,
                    validator: emailValidator,
                    controller: controller.emailController,
                    hintText: "Email ID",
                    textInputType: TextInputType.emailAddress,
                  ),
                  isSmallScreen ? verSpacing10 : verSpacing20,
                  CustomInputField(
                    icon: Icons.lock_rounded,
                    isPass: true,
                    hintText: "Password",
                    validator: passValidator,
                    controller: controller.passController,
                    textInputType: TextInputType.visiblePassword,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                      onPressed: controller.onForgotPasswordTap,
                      child: "Forgot?".text.make(),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  LoginButton(),
                  isSmallScreen ? verSpacing10 : verSpacing20,
                  Hero(
                    tag: "or",
                    child: Material(
                      color: Colors.transparent,
                      child: AdaptiveHide(
                        hideOn: ScreenSize.lg,
                        child: Center(
                          child: "Or Use".text.make(),
                        ),
                      ),
                    ),
                  ),
                  AdaptiveHide(
                    hideOn: ScreenSize.md,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GoogleButton(onTap: controller.onGoogleTap),
                        EmailButton(),
                        CallButton(onTap: controller.onCallTap),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginButton extends GetView<LoginController> {
  const LoginButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      id: controller.buttonId,
      init: controller,
      builder: (LoginController controller) {
        return Hero(
          tag: "button",
          child: IgnorePointer(
            ignoring: controller.isLoading,
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: primaryColor(context),
                padding: const EdgeInsets.all(18),
                shape: Sizing.cardShape,
              ),
              onPressed: controller.onLoginTap,
              child: controller.isLoading
                  ? CenterLoading(size: 18)
                  : "Login".text.bold.size(18).makeCentered(),
            ),
          ),
        );
      },
    );
  }
}

class EmailButton extends GetView<LoginController> {
  const EmailButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
      onPressed: controller.onRegisterTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Icon(
          Icons.email_rounded,
        ),
      ),
    );
  }
}
