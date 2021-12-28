import 'package:get/get.dart';
import 'package:shopping_app/app/core/utils/helper.dart';
import 'package:shopping_app/app/core/utils/mixins/services_mixin.dart';
import 'package:shopping_app/app/core/values/values.dart';
import 'package:shopping_app/app/modules/checkout/views/select_address_view.dart';

import 'checkout_controller.dart';

class SelectPaymentMethodController extends GetxController with ServicesMixin {
  late final checkoutController = CheckoutController.to;

  late final price = checkoutController.totalPrice;

  late final configData = configService.data!.config;
  late final isCodAvailable = configData?.isCodAvailable ?? false;
  late final isRazorPayAvailable = configData?.isRazorPayAvailable ?? false;

  late final codCharges = configData!.codCharges!;
  late final codFreeOn = configData!.codFreeOn!;

  late final razorPayCharges = configData!.razorPayCharges!;
  late final razorPayFreeOn = configData!.razorPayFreeOn!;

  int get totalPrice {
    if (paymentMethod == PaymentMethod.cashOnDelivery) {
      return price < codFreeOn ? price + codCharges : price;
    }
    if (paymentMethod == PaymentMethod.prepaid) {
      return price < razorPayFreeOn ? price + razorPayCharges : price;
    }
    return price;
  }

  late final _paymentMethod = Rxn<PaymentMethod>();
  get paymentMethod => _paymentMethod.value;
  set paymentMethod(value) => _paymentMethod.value = value;

  void onPaymentMethodChange(PaymentMethod? _paymentMethod) {
    paymentMethod = _paymentMethod;
  }

  void onConfirmOrder() {
    if (paymentMethod == null) {
      return errorSnackbar("Please select a payment method");
    } else {
      //update data
      updateCheckoutData();
      //select address
      gotoAddressView();
    }
  }

  void gotoAddressView() {
    Get.to(() => SelectAddressView());
  }

  void updateCheckoutData() {
    checkoutController
      ..updatePaymentMethod(paymentMethod)
      ..updateTotalPrice(totalPrice);
  }
}
