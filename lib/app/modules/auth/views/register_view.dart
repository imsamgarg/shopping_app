import 'package:flutter/material.dart';

import 'package:custom_utils/spacing_utils.dart';
import 'package:get/get.dart';
import 'package:shopping_app/app/core/values/assets.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:shopping_app/app/core/global_widgets/buttons.dart';
import 'package:shopping_app/app/core/global_widgets/input_fields.dart';
import 'package:shopping_app/app/core/global_widgets/responsive.dart';
import 'package:shopping_app/app/modules/auth/controllers/register_controller.dart';

class RegisterView extends StatelessWidget {
  final registerHeading =
      "Register".text.size(35).fontWeight(FontWeight.bold).make();

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RegisterController());

    final _height = context.screenHeight;
    final _bottomInsets = context.mq.viewInsets.bottom;
    final isSmallScreen = _height - _bottomInsets < 550;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: controller.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                HeaderImage(
                  image: Assets.assetsImagesRegister,
                  viewInsets: context.mq.viewInsets.bottom,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    isSmallScreen ? verSpacing10 : verSpacing30,
                    Hero(
                      tag: "heading",
                      child: Material(
                        color: Colors.transparent,
                        child: registerHeading,
                      ),
                    ),
                    isSmallScreen ? verSpacing10 : verSpacing20,
                    CustomInputField(
                      validator: controller.nameValidator,
                      controller: controller.nameController,
                      icon: Icons.person,
                      hintText: "Enter Name",
                      textInputType: TextInputType.name,
                    ),
                    isSmallScreen ? verSpacing10 : verSpacing20,
                    CustomInputField(
                      icon: Icons.alternate_email_outlined,
                      hintText: "Email ID",
                      validator: controller.emailValidator,
                      controller: controller.emailController,
                      textInputType: TextInputType.emailAddress,
                    ),
                    isSmallScreen ? verSpacing10 : verSpacing20,
                    CustomInputField(
                      icon: Icons.lock_rounded,
                      isPass: true,
                      hintText: "Password",
                      validator: controller.passValidator,
                      controller: controller.passController,
                      textInputType: TextInputType.visiblePassword,
                    ),
                    isSmallScreen ? verSpacing20 : verSpacing30,
                    const RegisterButton(),
                    isSmallScreen ? verSpacing10 : verSpacing20,
                    const OrTextWidget(),
                    verSpacing10,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GoogleButton(onTap: controller.onGoogleTap),
                        CallButton(onTap: controller.onCallTap),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ).px20(),
        ),
      ),
    );
  }
}

class OrTextWidget extends StatelessWidget {
  const OrTextWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Hero(
      tag: "or",
      child: Material(
        color: Colors.transparent,
        child: Center(
          child: Text("Or Use"),
        ),
      ),
    );
  }
}

class RegisterButton extends GetView<RegisterController> {
  const RegisterButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      id: controller.buttonId,
      init: controller,
      builder: (RegisterController controller) {
        return Hero(
          tag: "button",
          child: AppTextButton(
            isLoading: controller.isButtonLoading,
            onTap: controller.onRegisterTap,
            child: "Register".text.size(18).makeCentered(),
          ),
        );
      },
    );
  }
}
