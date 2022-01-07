import 'package:get/get.dart';

import 'package:shopping_app/app/core/utils/mixins/routes_mixin.dart';
import 'package:shopping_app/app/core/utils/mixins/services_mixin.dart';
import 'package:shopping_app/app/data/models/product_model.dart';
import 'package:shopping_app/app/modules/product/controllers/options_controller.dart';

class ProductController extends GetxController with ServicesMixin, RoutesMixin {
  late final optionsController = Get.find<OptionsController>();

  late final instance = _getData();
  late final ProductModel product;

  String? get productImage => product.img?[1];
  List<String>? get images {
    return product.img?.sublist(1);
  }

  String get id => product.id!;

  Map<String, Color>? get colorOptions => product.color;
  Map<String, int>? get sizeOptions => product.size;

  String get name => product.name ?? "Error In Name";
  String get shareableLink => product.link ?? "";

  late final _price = product.price.obs;
  int? get totalPrice => _price.value;

  String get description => product.description!;
  set totalPrice(value) => _price.value = value;

  void updatePrice() {
    int price = product.price!;

    final color = optionsController.color;
    if (color != null) {
      price += _getColorPrice(product, color);
    }

    final size = optionsController.size;
    if (size != null) {
      price += _getSizePrice(product, size);
    }
    totalPrice = price;
  }

  //* calculate price
  int _getColorPrice(ProductModel product, String color) {
    return product.color![color]!.priceDifferce!;
  }

  int _getSizePrice(ProductModel product, String size) {
    return product.size![size]!;
  }

  Future<bool> _getData() async {
    final argument = Get.arguments;
    if (argument is ProductModel) {
      product = argument;
      return true;
    }
    if (argument is String) {
      await _fetchFromDatabase(argument);
      return true;
    }
    throw Exception("No Product Found");
  }

  Future _fetchFromDatabase(String id) async {
    product = await productsService.getProduct(id);
  }
}
