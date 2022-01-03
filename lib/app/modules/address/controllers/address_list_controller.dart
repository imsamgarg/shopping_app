import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:shopping_app/app/core/utils/helper.dart';
import 'package:shopping_app/app/core/utils/mixins/routes_mixin.dart';
import 'package:shopping_app/app/core/utils/mixins/services_mixin.dart';
import 'package:shopping_app/app/data/models/user_model.dart';
import 'package:shopping_app/app/modules/address/views/address_view.dart';
import 'package:shopping_app/app/modules/address/views/confirm_delete_dialog_view.dart';

class AddressListController extends GetxController
    with ServicesMixin, RoutesMixin {
  final String deleteButtonId = "button";

  bool isButtonLoading = false;
  List<Address> get addresses => userService.user.address ?? [];

  void editAddress(int i) {
    Get.to(() => AddressView(index: i));
  }

  void deleteAddress(int index) async {
    Get.dialog(ConfirmDeleteDialogView(index));
  }

  void confirmDelete(int index) async {
    toggleLoading(true);
    await userService.delAddress(index);
    toggleLoading(false);
    goBack();
    customSnackBar(
      "Address Deleted",
      const Icon(Icons.delete_rounded),
      Colors.blueGrey,
    );
    update();
  }

  void toggleLoading(bool v) {
    isButtonLoading = v;
    update([deleteButtonId]);
  }

  void updateData() {
    update();
  }
}
