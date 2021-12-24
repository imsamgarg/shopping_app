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

  void changeColor(String? _color) {
    color = _color;
  }

  void changeSize(String? _size) {
    size = _size;
  }
}
