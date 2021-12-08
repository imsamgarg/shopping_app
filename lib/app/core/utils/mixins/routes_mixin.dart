import 'package:get/get.dart';
import 'package:shopping_app/app/data/models/app_model.dart';
import 'package:shopping_app/app/data/models/product_model.dart';
import 'package:shopping_app/app/modules/auth/views/google_auth_view.dart';
import 'package:shopping_app/app/modules/auth/views/phone_auth_view.dart';
import 'package:shopping_app/app/modules/auth/views/register_view.dart';
import 'package:shopping_app/app/modules/home/views/categories_view.dart';
import 'package:shopping_app/app/modules/home/views/sub_category_view.dart';
import 'package:shopping_app/app/routes/app_pages.dart';

mixin RoutesMixin {
  void onRegisterTap() => Get.to(() => RegisterView());

  void onGoogleTap() => Get.to(() => GoogleAuthView());

  void onCallTap() => Get.to(() => PhoneAuthView());

  void onProductTap(ProductModel product) {
    Get.toNamed(Routes.PRODUCT, arguments: product);
  }

  void onProductTapWithId(String? id) {
    Get.toNamed(Routes.PRODUCT, arguments: id);
  }

  void onOfferTap(Offer offer) {
    if (offer.isProduct ?? false) {
      onProductTapWithId(offer.id);
    } else {
      _gotoProductsList(offer.id!);
    }
  }

  void _gotoProductsList(String? id) {
    Get.toNamed(Routes.PRODUCT_LIST, arguments: id);
  }

  void onSubCategoryTap(String? name) {
    _gotoProductsList(name);
  }

  void onCategoryTap(Category cat) {
    Get.to(() => SubCategoryView(cat));
  }

  void onAllCategoriesTap() {
    Get.to(() => CategoriesView());
  }
}
