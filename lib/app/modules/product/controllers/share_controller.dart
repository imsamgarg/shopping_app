import 'package:get/get.dart';
import 'package:shopping_app/app/core/utils/helper.dart';

import 'package:shopping_app/app/core/utils/mixins/services_mixin.dart';
import 'package:shopping_app/app/core/utils/mixins/share_mixin.dart';
import 'package:shopping_app/app/modules/product/controllers/product_controller.dart';

class ShareController extends GetxController with ServicesMixin, ShareMixin {
  bool isButtonLoading = false;

  Future shareProduct() async {
    final controller = Get.find<ProductController>();
    final id = controller.id;
    final productImage = controller.productImage;
    final productName = controller.name;
    final productLink = controller.shareableLink;

    final shareContent =
        "Check Out $productName Only on Fashion24x7 \n link:-$productLink";

    toggleButtonLoading(true);
    try {
      final imagePath = await storageService.getImage(id, productImage!);
      //
      if (imagePath != null) {
        shareFile(imagePath, content: shareContent, subject: productName);
      } else {
        shareText(shareContent, subject: productName);
      }
      //
    } catch (e) {
      errorSnackbar("Error in Sharing Link");
      rethrow;
    } finally {
      toggleButtonLoading(false);
    }
  }

  void toggleButtonLoading(bool value) {
    isButtonLoading = value;
    update();
  }

  void onShareTap() async => shareProduct();
}
