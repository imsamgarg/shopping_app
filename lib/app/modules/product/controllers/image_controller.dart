import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:shopping_app/app/core/utils/mixins/routes_mixin.dart';

import 'package:shopping_app/app/modules/product/controllers/product_controller.dart';

class ProductImageController extends GetxController with RoutesMixin {
  String? image;
  late final productController = Get.find<ProductController>();
  late final imageLength = images.length;
  int currentImage = 0;

  String lastImageWidgetId = "lastImageWidgetId";

  final _showLeftSwipeButton = false.obs;
  get showLeftSwipeButton => _showLeftSwipeButton.value;
  set showLeftSwipeButton(value) => _showLeftSwipeButton.value = value;

  late final _showRightSwipeButton = (images.length > 2).obs;
  get showRightSwipeButton => _showRightSwipeButton.value;
  set showRightSwipeButton(value) => _showRightSwipeButton.value = value;

  List<String?> get images {
    return [...productController.images!, image];
  }

  late final PageController pageController = PageController();

  void setSecondaryImage(String? img) {
    if (img == null) {
      return;
    }
    image = img;
    showLastImage();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  void onInit() {
    pageController.addListener(() {});
    super.onInit();
  }

  void onLeftArrowPress() {
    if (currentImage == 0) return;
    int index = currentImage - 1;

    return animateToPage(index);
  }

  void onRightArrowPress() {
    if (currentImage == imageLength - 2) {
      if (images[imageLength - 1] == null) return;
    }
    int index = currentImage + 1;

    return animateToPage(index);
  }

  void showLastImage() {
    int index = imageLength - 1;
    if (index == currentImage) return updateImageUrl();

    return animateToPage(index);
  }

  void animateToPage(int index) {
    pageController.animateToPage(
      index,
      curve: Curves.easeInOut,
      duration: const Duration(milliseconds: 400),
    );

    return updateCurrentImageIndex(index);
  }

  void updateCurrentImageIndex(int index) {
    showLeftSwipeButton = index != 0;

    showRightSwipeButton =
        (index == imageLength - 1) ? false : (images[imageLength - 1] != null);

    currentImage = index;
  }

  void updateImageUrl() {
    update([lastImageWidgetId]);
  }
}
