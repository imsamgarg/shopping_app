import 'package:get/get.dart';
import 'package:shopping_app/app/core/utils/mixins/routes_mixin.dart';
import 'package:shopping_app/app/core/utils/mixins/services_mixin.dart';

class ProfileAuthController extends GetxController
    with RoutesMixin, ServicesMixin {
  String get phoneNumber => userService.phoneNumber;
  String get emailAddress => userService.mailAddress;
  String get googleMailAddress => userService.googleMailAddress;

  bool get hasMail => userService.hasMailProvider;
  bool get hasGoogle => userService.hasGoogleProvider;
  bool get hasPhone => userService.hasPhoneProvider;

  final String googleId = "google";
  final String mailId = "mail";
  final String phoneId = "phone";

  void updateWidget(String id) {
    update([id]);
  }

  void addPhoneNumber() async {
    if (hasPhone) return;
    await onCallTap(true);
    updateWidget(phoneId);
  }

  void addGoogle() async {
    if (hasGoogle) return;
    await authService.linkWithGoogle();
    updateWidget(googleId);
    updateWidget(mailId);
  }
}
