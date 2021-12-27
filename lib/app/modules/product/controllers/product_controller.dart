import 'package:get/get.dart';
import 'package:shopping_app/app/core/utils/mixins/services_mixin.dart';
import 'package:shopping_app/app/data/models/cart_model.dart';
import 'package:shopping_app/app/data/models/product_model.dart';
import 'package:shopping_app/app/modules/product/controllers/options_controller.dart';

class ProductController extends GetxController with ServicesMixin {
  late final optionsController = Get.find<OptionsController>();

  late final instance = _getData();
  late final ProductModel product;

  String? get productImage {}
  List<String>? get images {}

  String get id => product.id!;

  bool isAddToCartLoading = false;
  final String addToCartButtonId = "add_to_cart";

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

  void addToCart() async {
    final cartModel = createModel();
    toggleCartButtonLoading(true);

    await cartService.addToCart(cartModel);

    toggleCartButtonLoading(false);
  }

  void toggleCartButtonLoading(bool value) {
    isAddToCartLoading = value;
    update([addToCartButtonId]);
  }

  //TODO: implement
  void buyNow() {}

  CartModel createModel() {
    final color = optionsController.color;
    // final colorPrice = colorOptions?[color]?.priceDifferce;
    final size = optionsController.size;
    // final sizePrice = sizeOptions?[size];
    // int price = product.price!;
    // if (colorPrice != null) {
    //   price += colorPrice;
    // }
    // if (sizePrice != null) {
    //   price += sizePrice;
    // }
    return CartModel(
      color: color,
      size: size,
      // fullPrice: price,
      product: product,
    );
  }
}
