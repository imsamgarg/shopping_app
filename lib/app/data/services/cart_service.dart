import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import 'package:shopping_app/app/core/utils/mixins/services_mixin.dart';
import 'package:shopping_app/app/core/values/db_strings.dart';
import 'package:shopping_app/app/data/models/cart_model.dart';
import 'package:shopping_app/app/data/models/product_model.dart';
import 'package:shopping_app/app/data/repository/database_repository.dart';

class CartService extends GetxService with ServicesMixin {
  late final _repo = FirebaseDbRepository();

  Map<String, CartModel>? _cartMap;
  Map<String, CartModel> get cartMap => _cartMap!;

  late final userId = userService.uid;

  bool isProductsPopulated = false;

  static CartService service() => Get.find<CartService>();

  late final _cartLength = _getCartLength().obs;
  get cartLength => _cartLength.value;
  set cartLength(value) => _cartLength.value = value;

  Future<CartService> initService() async {
    if (_cartMap != null && isProductsPopulated) {
      return this;
    }

    _cartMap = await _getCartMap();
    await getCartProducts();

    isProductsPopulated = true;
    return this;
  }

  Future<Map<String, CartModel>> _getCartMap() async {
    final snapshot = await _repo.getSubCollectionDocument(
      collection: Db.usersCol,
      documentId: userId,
      subCollection: Db.cartSubCol,
      subColDocId: Db.cartSubCol,
    );

    final data = snapshot.data();

    return data?.map((k, v) => MapEntry(k, CartModel.fromJson(v))) ?? {};
  }

  Future getCartProducts() async {
    final ids = cartMap.keys.toList();
    final docs = await _repo.getDocsFromRealtimeDb(ids, Db.productCol);
    final products = docs.map((e) => ProductModel.fromJson(e));
    for (final product in products) {
      final cartItem = cartMap[product.id!]!;
      populateCartProductField(cartItem, product);
    }
  }

  CartModel populateCartProductField(CartModel cartItem, ProductModel product) {
    //populate Fields
    // final cartItem = cartItems[product.id!]!;
    cartItem.product = product;

    //if product is in stock
    cartItem.inStock = product.inStock ?? false;

    int price = product.price!;
    final color = cartItem.color;
    if (color != null) {
      cartItem.isColorInStock = _isColorInStock(product, color);
      price += _getColorPrice(product, color);
    }

    final size = cartItem.size;
    if (size != null) {
      cartItem.isSizeInStock = _isSizeInStock(product, size);
      price += _getSizePrice(product, size);
    }

    //populate the price
    cartItem.fullPrice = price;

    return cartItem;
  }

  //* check if options are available
  bool _isColorInStock(ProductModel product, String color) {
    return product.color?.containsKey(color) ?? false;
  }

  bool _isSizeInStock(ProductModel product, String size) {
    return product.size?.containsKey(size) ?? false;
  }

  //* calculate price
  int _getColorPrice(ProductModel product, String color) {
    return product.color![color]!.priceDifferce!;
  }

  int _getSizePrice(ProductModel product, String size) {
    return product.size![size]!;
  }

  ////////////////

  bool isProductInCart(String id) {
    return cartMap.containsKey(id);
  }

  Future<bool> addToCart(CartModel cartModel) async {
    final id = cartModel.product!.id!;
    if (isProductInCart(id)) {
      return false;
    }

    final product = cartModel.product!;
    populateCartProductField(cartModel, product);

    final data = cartModel.toJson();
    await addToDatabase(id, data);
    cartMap.putIfAbsent(id, () => cartModel);
    cartLength += 1;

    return true;
  }

  Future<void> _updateCartDatabase(Map<String, Object?> data) {
    return _repo.updateSubCollectionDocument(
      collection: Db.usersCol,
      documentId: userId,
      subCollection: Db.cartSubCol,
      subColDocId: Db.cartSubCol,
      data: data,
    );
  }

  Future<void> addToDatabase(String id, Map cartData) {
    final data = {id: cartData};

    return _updateCartDatabase(data);
  }

  Future removeFromCart(CartModel cartModel) async {
    final id = cartModel.product!.id!;
    // final data = cartItems.map((key, value) => MapEntry(key, value.toJson()));
    await deleteFromDatabase(id);
    //remove locally only after successfully removed from database
    cartMap.remove(id);
    cartLength -= 1;
  }

  Future<void> deleteFromDatabase(String id) {
    final data = {id: FieldValue.delete()};

    return _updateCartDatabase(data);
  }

  int _getCartLength() {
    var count = 0;
    for (final _ in cartMap.entries) {
      count += 1;
    }
    return count;
  }

  ////* No Longer Used
  // void incrementQuantity(String id) {
  //   ++cartItems[id]?.quantity;
  // }

  // void decrementQuantity(String id) {
  //   --cartItems[id]?.quantity;
  // }

  //so state can be mantained globally
  void changeQuantity(String id, int quantity) {
    cartMap[id]?.quantity = quantity;
  }

  CheckoutModel createCheckoutModel(
    List<CartModel> _cartItems, {
    bool shouldCalculatePrice = true,
  }) {
    int totalPrice = 0;
    for (final cartItem in _cartItems) {
      final product = cartItem.product!;

      //ignore calculations if already calculated
      if (shouldCalculatePrice) populateCartProductField(cartItem, product);

      final price = cartItem.fullPrice! * cartItem.quantity;
      totalPrice += price;
    }

    return CheckoutModel(cartItems: _cartItems, totalPrice: totalPrice);
  }
}
