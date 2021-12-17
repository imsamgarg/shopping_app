import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:shopping_app/app/core/utils/helper.dart';
import 'package:shopping_app/app/core/utils/mixins/routes_mixin.dart';
import 'package:shopping_app/app/core/utils/mixins/services_mixin.dart';
import 'package:shopping_app/app/routes/app_pages.dart';
import '../views/logout_confirm_dialog_view.dart';

class ProfileController extends GetxController with RoutesMixin, ServicesMixin {
  late final nameController = TextEditingController(text: userService.userName);

  late final focusNode = FocusNode();

  final RxBool _editingEnabled = false.obs;
  bool get editingEnabled => _editingEnabled.value;
  set editingEnabled(value) => _editingEnabled.value = value;

  late final RxString _name = userService.userName.obs;
  String get name => _name.value;
  set name(value) => _name.value = value;

  String? get image => userService.profileUrl;

  void logout() {
    Get.dialog(LogoutConfirmDialog());
  }

  void editProfile() async {
    if (editingEnabled) {
      await _saveChange();
      editingEnabled = false;
      unfocus();
    } else {
      editingEnabled = true;
      focusNode.requestFocus();
    }
  }

  void confirmLogout() async {
    await authService.logout();
    await Get.deleteAll();
    await deleteAllServices();
    await 1.delay();
    return Get.offAllNamed(Routes.STARTUP);
  }

  void unfocus() {
    editingEnabled = false;
    focusNode.unfocus();
  }

  void focus() {
    focusNode.requestFocus();
  }

  Future<void> _saveChange() async {
    await userService.updateUsername(nameController.text);
    name = nameController.text;
    successSnackbar("Name Changed");
  }
}
