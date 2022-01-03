import 'package:flutter/material.dart';

import 'package:custom_utils/spacing_utils.dart';
import 'package:get/get.dart';

import 'package:shopping_app/app/core/theme/sizing_theme.dart';
import 'package:shopping_app/app/core/utils/helper.dart';
import 'package:shopping_app/app/core/values/assets.dart';
import 'package:shopping_app/app/modules/auth/controllers/google_auth_controller.dart';

class GoogleAuthView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.put(GoogleAuthController());

    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Flexible(
            child: Center(
              child: GoogleLogo(),
            ),
          ),
          TryAgain(),
          verSpacing20,
        ],
      ),
    );
  }
}

class TryAgain extends GetView<GoogleAuthController> {
  const TryAgain({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      id: controller.buttonId,
      init: controller,
      builder: (GoogleAuthController controller) {
        if (controller.isTryAgainButtonVisible) {
          return TextButton(
            style: TextButton.styleFrom(
              backgroundColor: primaryColor(context),
              padding: const EdgeInsets.all(18),
              shape: Sizing.cardShape,
            ),
            onPressed: controller.onLoginWithGoogle,
            child: const Text(
              "Try Again",
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

class GoogleLogo extends StatelessWidget {
  const GoogleLogo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(microseconds: 600),
      child: Material(
        child: Hero(
          tag: "google",
          child: Image.asset(
            Assets.assetsImagesGLogo,
            height: 70,
            width: 70,
          ),
        ),
      ),
    );
  }
}
