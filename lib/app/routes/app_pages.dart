import 'package:get/get.dart';

import 'package:shopping_app/app/modules/address/bindings/address_binding.dart';
import 'package:shopping_app/app/modules/address/views/address_list_view.dart';
import 'package:shopping_app/app/modules/auth/bindings/auth_binding.dart';
import 'package:shopping_app/app/modules/auth/views/login_view.dart';
import 'package:shopping_app/app/modules/cart/bindings/cart_binding.dart';
import 'package:shopping_app/app/modules/cart/views/cart_view.dart';
import 'package:shopping_app/app/modules/checkout/bindings/checkout_binding.dart';
import 'package:shopping_app/app/modules/checkout/views/select_payment_method_view.dart';
import 'package:shopping_app/app/modules/home/bindings/home_binding.dart';
import 'package:shopping_app/app/modules/home/views/home_view.dart';
import 'package:shopping_app/app/modules/orders/bindings/orders_binding.dart';
import 'package:shopping_app/app/modules/orders/views/order_list_view.dart';
import 'package:shopping_app/app/modules/product/bindings/product_binding.dart';
import 'package:shopping_app/app/modules/product/views/product_view.dart';
import 'package:shopping_app/app/modules/product_list/bindings/product_list_binding.dart';
import 'package:shopping_app/app/modules/product_list/views/products_list_view.dart';
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
      name: _Paths.CART,
      page: () => CartView(),
      binding: CartBinding(),
    ),
    GetPage(
      name: _Paths.PRODUCT_LIST,
      page: () => ProductsListView(),
      binding: ProductListBinding(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: _Paths.PRODUCT,
      page: () => ProductView(),
      binding: ProductBinding(),
    ),
    GetPage(
      name: _Paths.ADDRESS,
      page: () => AddressListView(),
      binding: AddressBinding(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: _Paths.ORDERS,
      page: () => OrderListView(),
      binding: OrdersBinding(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: _Paths.CHECKOUT,
      page: () => SelectPaymentMethodView(),
      binding: CheckoutBinding(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: _Paths.AUTH,
      page: () => LoginView(),
      binding: AuthBinding(),
    ),
  ];
}
