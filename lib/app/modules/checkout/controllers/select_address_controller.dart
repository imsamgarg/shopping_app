import 'package:get/get.dart';
import 'package:shopping_app/app/core/utils/helper.dart';
import 'package:shopping_app/app/core/utils/mixins/services_mixin.dart';
import 'package:shopping_app/app/data/models/user_model.dart';
import 'package:shopping_app/app/modules/address/views/address_view.dart';
import 'package:shopping_app/app/modules/checkout/views/confirm_checkout_view.dart';

import 'checkout_controller.dart';

class SelectAddressController extends GetxController with ServicesMixin {
  late List<Address> addressList = userService.addreesList;
  late final checkoutController = CheckoutController.to;

  final _selectedAddress = RxnInt();
  get selectedAddress => _selectedAddress.value;
  set selectedAddress(value) => _selectedAddress.value = value;

  void onAddressChanged(int index) {
    selectedAddress = index;
  }

  void addAddress() async {
    await Get.to(() => AddressView());
    //update the ui
    update();
  }

  void onConfirmOrder() {
    if (selectedAddress == null) {
      return errorSnackbar("Please select a address");
    }
    //update address globally
    updateCheckoutData();

    //goto order confirmation view
    gotoConfirmationView();
  }

  void gotoConfirmationView() {
    Get.to(() => ConfirmCheckoutView());
  }

  void updateCheckoutData() {
    checkoutController.updateAddress(addressList[selectedAddress]);
  }
}
