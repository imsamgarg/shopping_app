import 'package:get/get.dart';
import 'package:shopping_app/app/core/utils/mixins.dart';
import 'package:shopping_app/app/core/values/db_strings.dart';
import 'package:shopping_app/app/data/models/cart_model.dart';
import 'package:shopping_app/app/data/models/product_model.dart';
import 'package:shopping_app/app/data/models/user_model.dart';
import 'package:shopping_app/app/data/repository/database_repository.dart';

class CartService extends GetxService with ServicesMixin {
  late final UserModel _user = userService.user;
  late final _repo = FirebaseDbRepository();
  late final _cart = _user.cartItems;
  bool isInit = false;

  static CartService service() => Get.find<CartService>();

  late final _cartLength = _getCartLength().obs;
  get cartLength => _cartLength.value;
  set cartLength(value) => _cartLength.value = value;

  Future<CartService> init() async {
    if (isInit) {
      return this;
    }
    await _getCartProducts();
    isInit = true;
    return this;
  }

  Future _getCartProducts() async {
    final ids = _cart.keys.toList();
    final docs = await _repo.getDocsFromRealtimeDb(ids, Db.productCol);
    final products = docs.map((e) => ProductModel.fromJson(e));
    for (var element in products) {
      _cart[element.id!]!.product = element;
    }
  }

  bool isInCart(String id) {
    return _cart.containsKey(id);
  }

  Future addToCart(CartModel cartModel) async {
    final id = cartModel.product!.id!;
    if (isInCart(id)) {
      return;
    }
    final data = cartModel.toJson();
    await _repo.updateFirebaseDocument(
      Db.usersCol,
      userService.uid,
      data: {
        Db.cartField: {id: data}
      },
    );
    _cart.putIfAbsent(id, () => cartModel);
    cartLength += 1;
  }

  Future removeFromCart(CartModel cartModel) async {
    final id = cartModel.product!.id!;
    _cart.remove(id);
    final data = _cart.map((key, value) => MapEntry(key, value.toJson()));
    await _repo.updateFirebaseDocument(
      Db.usersCol,
      userService.uid,
      data: {Db.cartField: data},
    );
    cartLength -= 1;
  }

  int _getCartLength() {
    var count = 0;
    for (final _ in _cart.entries) {
      count += 1;
    }
    return count;
  }
}
