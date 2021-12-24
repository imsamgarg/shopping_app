import 'package:get/get.dart';
import 'package:shopping_app/app/core/utils/mixins/services_mixin.dart';
import 'package:shopping_app/app/data/models/product_model.dart';

class ProductController extends GetxController with ServicesMixin {
  late final instance = _getData();
  late final ProductModel product;

  String? get productImage {}
  List<String>? get images {}

  String get id => product.id!;

  Map<String, Color>? get colorOptions => product.color;
  Map<String, int>? get sizeOptions => product.size;

  String get name => product.name ?? "Error In Name";
  String get shareableLink => product.link ?? "";

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
