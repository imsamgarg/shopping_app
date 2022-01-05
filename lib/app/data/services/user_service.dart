import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import 'package:shopping_app/app/core/values/db_strings.dart';
import 'package:shopping_app/app/data/models/product_model.dart';
import 'package:shopping_app/app/data/models/user_model.dart';
import 'package:shopping_app/app/data/repository/database_repository.dart';
import 'package:shopping_app/app/data/repository/user_repository.dart';
import 'package:shopping_app/app/modules/home/controllers/favourite_controller.dart';

class UserService extends GetxService with _Address, _Favourite, _Parent {
  String get userName => _userRepo.userName;
  String get phoneNumber => _userRepo.phoneNumber;
  String? get profileUrl => _userRepo.profileUrl;
  bool get hasGoogleProvider => _userRepo.hasGoogleProvider;
  bool get hasMailProvider => _userRepo.hasMailProvider;
  bool get hasPhoneProvider => _userRepo.hasPhoneProvider;

  Future<String>? get token => _userRepo.token;

  String get mailAddress => _userRepo.mailAddress;
  String get googleMailAddress => _userRepo.googleEmail;

  static UserService service() => Get.find<UserService>();

  Future<bool> isUserSignedIn() => _userRepo.isUserLogged();

  Future<void> initUser() async {
    final doc = await _dbRepo.getDocumentFromFirestore(uid, Db.usersCol);
    user = UserModel.fromJson(doc);
  }

  Future updateUsername(String name) async {
    return await _userRepo.updateName(name);
  }
}

mixin _Parent {
  late final _userRepo = FirebaseUserRepository();
  late final _dbRepo = FirebaseDbRepository();
  String get uid => _userRepo.uid;
  late final UserModel user;
}

mixin _Address implements _Parent {
  List<Address> get addreesList => user.address ?? [];

  Future addAddress(Address address) async {
    final data = address.toJson();
    await _dbRepo.updateFirebaseDocument(
      Db.usersCol,
      uid,
      data: {
        Db.addressField: FieldValue.arrayUnion([data]),
      },
    );
    user.address?.add(address);
  }

  Future updateAddress(Address address, int index) async {
    user.address?.removeAt(index);
    user.address?.add(address);
    final data = user.address?.map((e) => e.toJson()).toList().toString();
    return await _dbRepo.updateFirebaseDocument(
      Db.usersCol,
      uid,
      data: {
        Db.addressField: data,
      },
    );
  }

  Future delAddress(int index) async {
    final data = user.address?[index].toJson();
    await _dbRepo.updateFirebaseDocument(
      Db.usersCol,
      uid,
      data: {
        Db.addressField: FieldValue.arrayRemove([data]),
      },
    );
    user.address?.removeAt(index);
  }
}

mixin _Favourite implements _Parent {
  bool isProductFavourite(String id) {
    return user.favourites.containsKey(id);
  }

  Future<List<ProductModel>> getFavouriteProducts(int start, int end) async {
    int length = user.favourites.length;
    final favouriteProductList = user.favourites.keys.map((e) => e).toList();

    late int _end;
    if (end > length) {
      _end = length;
    } else {
      _end = end;
    }
    final docs = await _dbRepo.getDocsFromRealtimeDb(
      favouriteProductList.sublist(start, _end),
      Db.productCol,
    );
    return docs.map((e) => ProductModel.fromJson(e)).toList();
  }

  Future<void> removeFavouriteProduct(String id) async {
    user.favourites.remove(id);

    final data = user.favourites;

    await _dbRepo.updateFirebaseDocument(
      Db.usersCol,
      uid,
      data: {Db.favouriteField: data},
    );

    removeFromFavouritesUi(id);
  }

  Future<void> addFavouriteProduct(String id, ProductModel product) async {
    final time = Timestamp.now();
    user.favourites.putIfAbsent(id, () => time);

    final data = user.favourites;

    await _dbRepo.updateFirebaseDocument(
      Db.usersCol,
      uid,
      data: {
        Db.favouriteField: data,
      },
    );

    addToFavouritesUi(product);
  }

  void removeFromFavouritesUi(String id) {
    Get.find<FavouriteController>().removeFavouriteProduct(id: id);
  }

  void addToFavouritesUi(ProductModel product) {
    Get.find<FavouriteController>().addFavouriteProduct(product);
  }

  Future<bool> toggleFavourite(String id, {ProductModel? product}) async {
    if (isProductFavourite(id)) {
      await removeFavouriteProduct(id);
      return false;
    }

    await addFavouriteProduct(id, product!);
    return true;
  }
}
