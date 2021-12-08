import 'package:shopping_app/app/data/services/auth_service.dart';
import 'package:shopping_app/app/data/services/cart_service.dart';
import 'package:shopping_app/app/data/services/config_service.dart';
import 'package:shopping_app/app/data/services/dynamic_link_service.dart';
import 'package:shopping_app/app/data/services/orders_service.dart';
import 'package:shopping_app/app/data/services/products_service.dart';
import 'package:shopping_app/app/data/services/user_service.dart';

mixin ServicesMixin {
  late final AuthService authService = AuthService.service();
  late final UserService userService = UserService.service();
  late final CartService cartService = CartService.service();
  late final ConfigService configService = ConfigService.service();
  late final OrdersService ordersService = OrdersService.service();
  late final ProductsService productsService = ProductsService.service();
  late final DynamicLinkService linkService = DynamicLinkService.service();
}
