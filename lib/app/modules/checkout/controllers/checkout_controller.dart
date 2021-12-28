import 'package:get/get.dart';
import 'package:shopping_app/app/core/values/values.dart';
import 'package:shopping_app/app/data/models/user_model.dart';

class CheckoutController extends GetxController {
  static CheckoutController get to => Get.find<CheckoutController>();

  PaymentMethod? _paymentMethod;
  late int totalPrice;
  late Address address;

  @override
  void onInit() {
    super.onInit();
  }

  void updatePaymentMethod(paymentMethod) {
    _paymentMethod = paymentMethod;
  }

  void updateTotalPrice(int finalPrice) {
    totalPrice = finalPrice;
  }

  void updateAddress(Address _address) {
    address = _address;
  }
}
