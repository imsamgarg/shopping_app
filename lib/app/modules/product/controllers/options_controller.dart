import 'package:get/get.dart';
import 'package:shopping_app/app/modules/product/controllers/image_controller.dart';

import 'product_controller.dart';

class OptionsController extends GetxController {
  late final productController = Get.find<ProductController>();
  late final imageController = Get.find<ProductImageController>();

  late final _colorOptions = productController.colorOptions;
  late final _sizeOptions = productController.sizeOptions;

  late final colorOptions = _colorOptions?.entries.map((e) => e.key).toList();
  late final sizeOptions = _sizeOptions?.entries.map((e) => e.key).toList();

  final _color = RxnString();
  get color => _color.value;
  set color(value) => _color.value = value;

  final _size = RxnString();
  get size => _size.value;
  set size(value) => _size.value = value;

  final _quantity = 1.obs;
  int get quantity => _quantity.value;
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

    final image = _colorOptions?[color]?.img;
    if (image != null) {
      imageController.setSecondaryImage(image);
    }
  }

  void changeSize(String? _size) {
    size = _size;
    productController.updatePrice();
  }
}
