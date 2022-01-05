import 'package:get/get.dart';

import 'package:shopping_app/app/core/values/values.dart';
import 'package:shopping_app/app/data/models/cart_model.dart';
import 'package:shopping_app/app/data/models/category_model.dart';
import 'package:shopping_app/app/data/models/dynamic_link_model.dart';
import 'package:shopping_app/app/data/models/product_model.dart';
import 'package:shopping_app/app/modules/address/views/address_view.dart';
import 'package:shopping_app/app/modules/auth/views/google_auth_view.dart';
import 'package:shopping_app/app/modules/auth/views/phone_auth_view.dart';
import 'package:shopping_app/app/modules/auth/views/register_view.dart';
import 'package:shopping_app/app/modules/home/views/categories_view.dart';
import 'package:shopping_app/app/modules/home/views/sub_category_view.dart';
import 'package:shopping_app/app/modules/product/views/image_view.dart';
import 'package:shopping_app/app/routes/app_pages.dart';

mixin RoutesMixin {
  void onRegisterTap() => Get.to(() => RegisterView());

  void onGoogleTap() => Get.to(() => GoogleAuthView());

  Future? onCallTap([bool? link]) {
    return Get.to(() => PhoneAuthView(link: link ?? false));
  }

  void onAddressListTap() => Get.toNamed(Routes.ADDRESS);

  void onImageTap(String image) => Get.to(() => ImageView(image: image));

  void onAddAddressTap() => Get.to(() => const AddressView());

  void onOrderTap() => Get.toNamed(Routes.ORDERS);

  void onCartTap() => Get.toNamed(Routes.CART);

  void onProductTap(ProductModel product) {
    Get.toNamed(Routes.PRODUCT, arguments: product);
  }

  void onProductTapWithId(String? id) {
    Get.toNamed(Routes.PRODUCT, arguments: id);
  }

  void _gotoProductsList({
    String? category,
    String? subCategory,
    bool? isPopular,
  }) {
    final model = ProductQueryModel(
      category: category,
      subCategory: subCategory,
      isPopular: isPopular,
    );
    Get.toNamed(Routes.PRODUCT_LIST, arguments: model);
  }

  void onSubCategoryTap({
    SubCategory? subCategory,
    bool isPopular = false,
  }) {
    _gotoProductsList(
      category: subCategory?.category,
      subCategory: subCategory?.name,
      isPopular: isPopular,
    );
  }

  void onCategoryTap(Category cat) {
    Get.to(() => SubCategoryView(cat));
  }

  void onAllCategoriesTap() {
    Get.to(() => CategoriesView());
  }

  void handleLink(DynamicLink? link) {
    if (link == null) return;
    final id = link.id;
    switch (link.linkType) {
      case DynamicLinkType.product:
        onProductTapWithId(id);
        break;
      case DynamicLinkType.subCategory:
        {
          final subCategory = SubCategory(
            category: link.category,
            name: link.subCategory,
          );
          onSubCategoryTap(subCategory: subCategory);
          break;
        }
      // case DynamicLinkType.order:
      //   break;
      // case DynamicLinkType.offer:
      //   break;
      default:
        break;
    }
  }

  void onCheckoutTap(CheckoutModel checkoutModel) {
    Get.toNamed(Routes.CHECKOUT, arguments: checkoutModel);
  }
}
