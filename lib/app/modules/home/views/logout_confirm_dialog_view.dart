import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:shopping_app/app/core/global_widgets/buttons.dart';
import 'package:shopping_app/app/core/theme/sizing_theme.dart';
import 'package:shopping_app/app/modules/home/controllers/profile_controller.dart';

class LogoutConfirmDialog extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Confirm Logout"),
      backgroundColor: Theme.of(context).dialogBackgroundColor,
      shape: RoundedRectangleBorder(
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
          heading: "No",
        ),
        DialogButton(
          onTap: controller.confirmLogout,
          color: Theme.of(context).primaryColor,
          // color: Vx.red500,
          heading: "Yes",
        ),
      ],
    );
  }
}
