import 'package:get/get.dart';

import 'product_controller.dart';

class OptionsController extends GetxController {
  late final productController = Get.find<ProductController>();

  late final colorOptions = productController.colorOptions;
  late final sizeOptions = productController.sizeOptions;

  final _color = RxnString();
  get color => _color.value;
  set color(value) => _color.value = value;

  final _size = RxnString();
  get size => _size.value;
  set size(value) => _size.value = value;

  final _quantity = 1.obs;
  get quantity => _quantity.value;
  set quantity(value) => _quantity.value = value;

  void incrementQuantity() {
    if (quantity >= 10) {
      return;
    }
    ++quantity;
  }

  void decrementQuantity() {
    if (quantity == 1) {
      return;
    }
    --quantity;
  }

  void changeColor(String? _color) {
    color = _color;
    productController.updatePrice();
  }

  void changeSize(String? _size) {
    size = _size;
    productController.updatePrice();
  }
}
