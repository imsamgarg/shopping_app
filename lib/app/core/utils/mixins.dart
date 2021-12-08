import 'package:custom_utils/log_utils.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/utils.dart';
import 'package:shopping_app/app/data/services/auth_service.dart';
import 'package:shopping_app/app/data/services/cart_service.dart';
import 'package:shopping_app/app/data/services/config_service.dart';
import 'package:shopping_app/app/data/services/dynamic_link_service.dart';
import 'package:shopping_app/app/data/services/orders_service.dart';
import 'package:shopping_app/app/data/services/products_service.dart';
import 'package:shopping_app/app/data/services/user_service.dart';
import 'package:shopping_app/app/modules/auth/views/google_auth_view.dart';
import 'package:shopping_app/app/modules/auth/views/register_view.dart';
import 'package:shopping_app/app/modules/auth/views/phone_auth_view.dart';

mixin Validators {
  String? phoneNumberValidator(String? value, [int minLen = 10]) {
    value ??= "";
    value.removeAllWhitespace;

    if (value.isEmpty) return "Please Enter Phone Number";
    if (!value.isPhoneNumber) return "Enter Valid Number";
    if (value.length < 10) return "Enter Valid Number";
    return null;
  }

  String? emailValidator(String? value, [int minLen = 10]) {
    value ??= "";
    value.removeAllWhitespace;
    if (value.isEmpty) return "Please Enter Phone Number";
    if (!value.isEmail) return "Please Enter Valid Email";
    return null;
  }

  String? passValidator(String? value, [int minLen = 10]) {
    value ??= "";
    value.removeAllWhitespace;

    if (value.isEmpty) return "Please Enter Password";
    return null;
  }

  String? otpCodeValidator(String? value, [int minLen = 6]) {
    value ??= "";
    value.removeAllWhitespace;

    if (value.isEmpty) return "Please Enter Otp";
    if (!value.isNumericOnly) return "Only Digits Are Allowed";
    if (value.length != minLen) return "Enter 6 Digits ";
    return null;
  }

  String? nameValidator(String? value, [bool numbersAllowed = false]) {
    value ??= "";
    value = value.removeAllWhitespace;
    if (value.isEmpty) return "Please Enter Name";
    customLog(value);
    if (!value.isAlphabetOnly && !numbersAllowed) {
      return "Only Alphabets Are Allowed";
    }
    return null;
  }

  String? requiredValidator(String? value, [int? minLen, int? maxLen]) {
    value ??= "";
    value = value.removeAllWhitespace;
    if (value.isEmpty) return "Please Enter Value";
    if (minLen != null && value.length < minLen) {
      return "Enter Min $minLen Characters";
    }
    if (maxLen != null && value.length > maxLen) {
      return "Max $maxLen Characters Allowed";
    }
  }
}

mixin AuthMixin {
  late final AuthService service = AuthService.service();

  void onRegisterTap() => Get.to(() => RegisterView());

  void onGoogleTap() => Get.to(() => GoogleAuthView());

  void onCallTap() => Get.to(() => PhoneAuthView());
}

mixin ServicesMixin {
  late final AuthService authService = AuthService.service();
  late final UserService userService = UserService.service();
  late final CartService cartService = CartService.service();
  late final ConfigService configService = ConfigService.service();
  late final OrdersService ordersService = OrdersService.service();
  late final ProductsService productsService = ProductsService.service();
  late final DynamicLinkService linkService = DynamicLinkService.service();
}
