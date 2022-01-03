import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import 'package:shopping_app/app/core/values/db_strings.dart';
import 'package:shopping_app/app/core/values/values.dart';
import 'package:shopping_app/app/data/models/filter_map_model.dart';
import 'package:shopping_app/app/data/models/product_model.dart';
import 'package:shopping_app/app/data/repository/database_repository.dart';

class ProductsService extends GetxService {
  static ProductsService service() => Get.find<ProductsService>();

  late final _repo = FirebaseDbRepository();

  Future<ProductModel> getProduct(String id) async {
    //just comment and uncomment to change

    // final doc = await _repo.getDocumentFromFirestore(id, Db.productCol);
    final doc = await _repo.getDocumentFromRealtimeDb(id, Db.productCol);
    return ProductModel.fromJson(doc);
  }

  Future<FilterMap> getFilter(String id) async {
    final doc = await _repo.getDocumentFromFirestore(id, Db.filterMapCol);
    return FilterMap.fromJson(doc);
  }

  Future<List<ProductSnapshot>> getPopularProducts({
    int count = 10,
    DocumentSnapshot? startAfter,
  }) async {
    return await _repo.getProducts(
      count: count,
      startAfter: startAfter,
      //Not Used
      isPopular: true,
      sortBy: SortBy.popularity,
    );
  }

  Future<List<ProductSnapshot>> getProducts({
    int count = 10,
    bool? isPopular,
    int? minPrice,
    int? maxPrice,
    String? size,
    String? color,
    String? category,
    String? subCategory,
    DocumentSnapshot? startAfter,
    SortBy sortBy = SortBy.popularity,
  }) async {
    return await _repo.getProducts(
      count: count,
      isPopular: isPopular,
      sortBy: sortBy,
      startAfter: startAfter,
      color: color,
      category: category,
      subCategory: subCategory,
      maxPrice: maxPrice,
      minPrice: minPrice,
      size: size,
    );
  }
}
