import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shopping_app/app/core/utils/mixins/services_mixin.dart';
import 'package:shopping_app/app/core/values/db_strings.dart';
import 'package:shopping_app/app/data/models/product_model.dart';
import 'package:shopping_app/app/data/repository/database_repository.dart';
import 'package:shopping_app/app/modules/home/controllers/favourite_controller.dart';

class FavouriteService extends GetxService with ServicesMixin {
  Map<String, Timestamp>? favouriteMap;

  List<String> get favouriteList {
    return favouriteMap?.keys.map((e) => e).toList() ?? <String>[];
  }

  static FavouriteService service() => Get.find<FavouriteService>();

  late final _dbRepo = FirebaseDbRepository();
  late final userId = userService.uid;

  Future<FavouriteService> initService() async {
    if (favouriteMap != null) {
      return this;
    }

    favouriteMap = await _getFavourites();
    return this;
  }

  Future<Map<String, Timestamp>> _getFavourites() async {
    final snapshot = await _dbRepo.getSubCollectionDocument(
      collection: Db.usersCol,
      documentId: userId,
      subCollection: Db.favouriteSubCol,
      subColDocId: Db.favouriteSubCol,
    );

    return snapshot.data()?.map((k, v) => MapEntry(k, v)) ?? {};
  }

  Future<List<ProductModel>> getFavouriteProducts(int start, int end) async {
    int length = favouriteMap!.length;
    final favouriteProductList = favouriteMap!.keys.map((e) => e).toList();

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

  bool isProductFavourite(String id) {
    return favouriteMap!.containsKey(id);
  }

  Future<void> removeFavouriteProduct(String id) async {
    final data = {id: FieldValue.delete()};

    await _dbRepo.updateSubCollectionDocument(
      collection: Db.usersCol,
      documentId: userId,
      subCollection: Db.favouriteSubCol,
      subColDocId: Db.favouriteSubCol,
      data: data,
    );

    favouriteMap!.remove(id);
    removeFromFavouritesUi(id);
  }

  Future<void> addFavouriteProduct(String id, ProductModel product) async {
    final time = Timestamp.now();

    final data = {id: time};

    await _dbRepo.updateSubCollectionDocument(
      collection: Db.usersCol,
      documentId: userId,
      subCollection: Db.favouriteSubCol,
      subColDocId: Db.favouriteSubCol,
      data: data,
    );

    favouriteMap!.putIfAbsent(id, () => time);
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
