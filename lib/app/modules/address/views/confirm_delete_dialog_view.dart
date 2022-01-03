import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:shopping_app/app/core/global_widgets/buttons.dart';
import 'package:shopping_app/app/core/theme/sizing_theme.dart';
import 'package:shopping_app/app/modules/address/controllers/address_list_controller.dart';

class ConfirmDeleteDialogView extends GetView<AddressListController> {
  ConfirmDeleteDialogView(this.index);
  final int index;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Confirm Delete"),
      backgroundColor: Theme.of(context).dialogBackgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: Sizing.borderRadiusS,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            "Are You Sure Want To Delete?",
          ),
        ],
      ),
      actions: [
        DialogButton(
          onTap: () => Get.back(),
          textColor: Theme.of(context).primaryColor,
          heading: "No",
        ),
        GetBuilder<AddressListController>(
          init: controller,
          id: controller.deleteButtonId,
          builder: (_) {
            return DialogButton(
              onTap: () => controller.confirmDelete(index),
              color: Theme.of(context).primaryColor,
              isLoading: controller.isButtonLoading,
              heading: "Yes",
            );
          },
        ),
      ],
    );
  }
}
