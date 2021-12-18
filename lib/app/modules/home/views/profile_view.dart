import 'package:custom_utils/spacing_utils.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:shopping_app/app/core/global_widgets/buttons.dart';
import 'package:shopping_app/app/core/global_widgets/cached_image.dart';
import 'package:shopping_app/app/core/theme/color_theme.dart';
import 'package:shopping_app/app/core/utils/helper.dart';
import 'package:shopping_app/app/core/utils/mixins/validator_mixin.dart';
import 'package:shopping_app/app/core/values/assets.dart';
import 'package:shopping_app/app/modules/home/controllers/profile_auth_controller.dart';
import 'package:shopping_app/app/modules/home/controllers/profile_controller.dart';
import 'package:velocity_x/velocity_x.dart';

class ProfileView extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            verSpacing20,
            ProfileImage(),
            verSpacing20,
            _NameField(),
            verSpacing12,
            _GoogleAuth(),
            verSpacing8,
            _PhoneAuth(),
            verSpacing8,
            _MailAuth(),
            verSpacing8,
            _CustomButton(
              onTap: controller.logout,
              title: "Your Cart",
            ),
            _CustomButton(
              onTap: controller.onAddressListTap,
              title: "Your Address",
            ),
            _CustomButton(
              onTap: controller.onOrderTap,
              title: "Your Orders",
            ),
            _CustomButton(
              onTap: controller.logout,
              title: "Logout",
              color: primaryColor(context),
            ),
          ],
        ).px16().scrollVertical(),
      ),
    ).onTap(controller.unfocus);
  }
}

class _GoogleAuth extends GetView<ProfileAuthController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileAuthController>(
      init: controller,
      id: controller.googleId,
      builder: (_) {
        return _AuthButton(
          image: Assets.assetsImagesGLogo,
          text: controller.googleMailAddress,
          onTap: controller.addGoogle,
        );
      },
    );
  }
}

class _PhoneAuth extends GetView<ProfileAuthController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileAuthController>(
      init: controller,
      id: controller.phoneId,
      builder: (_) {
        return _AuthButton(
          icon: Icon(Icons.phone_enabled_rounded),
          text: controller.phoneNumber,
          onTap: controller.addPhoneNumber,
        );
      },
    );
  }
}

class _MailAuth extends GetView<ProfileAuthController> {
  @override
  Widget build(BuildContext context) {
    if (controller.hasMail) {
      return GetBuilder<ProfileAuthController>(
        init: controller,
        id: controller.mailId,
        builder: (_) {
          return _AuthButton(
            icon: Icon(
              Icons.email_rounded,
              color: Colors.blueGrey,
            ),
            text: controller.emailAddress,
            onTap: () {},
          );
        },
      );
    }
    return SizedBox.shrink();
  }
}

class _CustomButton extends StatelessWidget {
  const _CustomButton({
    Key? key,
    required this.onTap,
    required this.title,
    this.color,
  }) : super(key: key);

  final Color? color;
  final VoidCallback onTap;
  final String title;

  @override
  Widget build(BuildContext context) {
    return AppTextButton(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          title.text.bold.size(16).make(),
          Icon(
            Icons.arrow_forward_ios_rounded,
            size: 20,
          )
        ],
      ),
      onTap: onTap,
      foregroundColor: color ?? ColorTheme.textColor,
      color: Vx.white,
    );
  }
}

class _AuthButton extends StatelessWidget {
  final String? image;
  final String text;
  final VoidCallback onTap;
  final Icon? icon;
  const _AuthButton({
    Key? key,
    this.image,
    required this.text,
    required this.onTap,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppTextButton(
      onTap: onTap,
      color: Vx.white,
      foregroundColor: ColorTheme.textColor,
      child: Row(
        children: [
          if (image != null)
            Image.asset(
              image!,
              height: 22,
              width: 22,
            ),
          if (icon != null) icon!,
          horSpacing20,
          text.text.bold.size(16).make(),
        ],
      ),
    );
  }
}

class ProfileImage extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipOval(
        child: Container(
          height: 80,
          width: 80,
          color: primaryColor(context),
          child: (controller.image == null)
              ? Obx(
                  () => controller.name[0].text
                      .size(40)
                      .white
                      .uppercase
                      .bold
                      .makeCentered(),
                )
              : CachedFirebaseImage(url: controller.image!),
        ),
      ),
    );
  }
}

class _NameField extends GetView<ProfileController> with ValidatorMixin {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => TextFormField(
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: ColorTheme.textColor,
        ),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(left: 20),
          prefixIcon: Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Icon(
              Icons.account_circle_rounded,
              size: 28,
            ),
          ),
          suffixIcon: IconButton(
            onPressed: controller.editProfile,
            icon: Icon(
              controller.editingEnabled ? Icons.check_rounded : Icons.edit,
            ),
          ),
          border: OutlineInputBorder(borderSide: BorderSide.none),
        ),
        focusNode: controller.focusNode,
        controller: controller.nameController,
        readOnly: !controller.editingEnabled,
        validator: (v) => nameValidator(v),
      ),
    ).pOnly(left: 12);
  }
}
