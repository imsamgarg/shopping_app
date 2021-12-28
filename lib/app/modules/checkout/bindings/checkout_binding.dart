import 'package:get/get.dart';

import 'package:shopping_app/app/modules/checkout/controllers/payment_controller.dart';
import 'package:shopping_app/app/modules/checkout/controllers/select_payment_controller.dart';

import '../controllers/checkout_controller.dart';

class CheckoutBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PaymentController>(
      () => PaymentController(),
    );

    Get.lazyPut<SelectPaymentMethodController>(
      () => SelectPaymentMethodController(),
    );
    Get.lazyPut<CheckoutController>(
      () => CheckoutController(),
    );
  }
}
