import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:shopping_app/app/core/global_widgets/buttons.dart';
import 'package:shopping_app/app/core/theme/sizing_theme.dart';
import 'package:shopping_app/app/modules/home/controllers/profile_controller.dart';
import 'package:velocity_x/velocity_x.dart';

class LogoutConfirmDialog extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Confirm Logout"),
      backgroundColor: Theme.of(context).dialogBackgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(Sizing.radiusS)),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            "Are You Sure Want To Logout?",
          ),
        ],
      ),
      actions: [
        DialogButton(
          onTap: () => Get.back(),
          textColor: Theme.of(context).primaryColor,
          color: Vx.white,
          heading: "No",
        ),
        DialogButton(
          onTap: controller.confirmLogout,
          // color: Theme.of(context).primaryColor,
          // textColor: Vx.white,
          // color: Vx.red500,
          heading: "Yes",
        ),
      ],
    );
  }
}
