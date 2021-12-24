import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/app/modules/product/controllers/product_controller.dart';

class ProductImageController extends GetxController {
  String? image;
  late final productController = Get.find<ProductController>();
  late final images = productController.images;
  late final PageController pageController = PageController();

  void setSecondaryImage(String? img) {
    image = img;
  }
}
