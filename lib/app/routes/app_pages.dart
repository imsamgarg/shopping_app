import 'package:get/get.dart';

import 'package:shopping_app/app/modules/address/bindings/address_binding.dart';
import 'package:shopping_app/app/modules/address/views/address_view.dart';
import 'package:shopping_app/app/modules/cart/bindings/cart_binding.dart';
import 'package:shopping_app/app/modules/cart/views/cart_view.dart';
import 'package:shopping_app/app/modules/checkout/bindings/checkout_binding.dart';
import 'package:shopping_app/app/modules/checkout/views/checkout_view.dart';
import 'package:shopping_app/app/modules/home/bindings/home_binding.dart';
import 'package:shopping_app/app/modules/home/views/home_view.dart';
import 'package:shopping_app/app/modules/login/bindings/login_binding.dart';
import 'package:shopping_app/app/modules/login/views/login_view.dart';
import 'package:shopping_app/app/modules/orders/bindings/orders_binding.dart';
import 'package:shopping_app/app/modules/orders/views/orders_view.dart';
import 'package:shopping_app/app/modules/phone_auth/bindings/phone_auth_binding.dart';
import 'package:shopping_app/app/modules/phone_auth/views/phone_auth_view.dart';
import 'package:shopping_app/app/modules/product/bindings/product_binding.dart';
import 'package:shopping_app/app/modules/product/views/product_view.dart';
import 'package:shopping_app/app/modules/register/bindings/register_binding.dart';
import 'package:shopping_app/app/modules/register/views/register_view.dart';
import 'package:shopping_app/app/modules/startup/bindings/startup_binding.dart';
import 'package:shopping_app/app/modules/startup/views/startup_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.STARTUP;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.STARTUP,
      page: () => StartupView(),
      binding: StartupBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.PHONE_AUTH,
      page: () => PhoneAuthView(),
      binding: PhoneAuthBinding(),
    ),
    GetPage(
      name: _Paths.CART,
      page: () => CartView(),
      binding: CartBinding(),
    ),
    GetPage(
      name: _Paths.PRODUCT,
      page: () => ProductView(),
      binding: ProductBinding(),
    ),
    GetPage(
      name: _Paths.ADDRESS,
      page: () => AddressView(),
      binding: AddressBinding(),
    ),
    GetPage(
      name: _Paths.ORDERS,
      page: () => OrdersView(),
      binding: OrdersBinding(),
    ),
    GetPage(
      name: _Paths.CHECKOUT,
      page: () => CheckoutView(),
      binding: CheckoutBinding(),
    ),
  ];
}
