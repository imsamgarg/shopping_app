import 'package:get/get.dart';
import 'package:shopping_app/app/core/values/values.dart';
import 'package:shopping_app/app/data/models/cart_model.dart';
import 'package:shopping_app/app/data/models/user_model.dart';
import 'package:shopping_app/app/modules/checkout/views/checkout_loading_view.dart';

class CheckoutController extends GetxController {
  static CheckoutController to = Get.find<CheckoutController>();
  late final List<CartModel> cartItems;

  late PaymentMethod _paymentMethod;
  late int totalPrice;
  late Address address;

  @override
  void onInit() {
    populateFieldsFromArgument();
    super.onInit();
  }

  String get paymentMethod {
    switch (_paymentMethod) {
      case PaymentMethod.cashOnDelivery:
        return "Cash On Delivery";
      case PaymentMethod.prepaid:
        return "Online Payment";
    }
  }

  void populateFieldsFromArgument() {
    final arguments = Get.arguments as CheckoutModel;
    cartItems = arguments.cartItems;
    totalPrice = arguments.totalPrice;
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

  void onConfirmOrder() {
    Get.to(() => CheckoutLoadingView());
  }
}
