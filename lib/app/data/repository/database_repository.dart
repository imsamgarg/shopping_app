import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart' as db;

import 'package:shopping_app/app/core/values/db_strings.dart';
import 'package:shopping_app/app/core/values/values.dart';
import 'package:shopping_app/app/data/models/product_model.dart';

class FirebaseDbRepository {
  static final FirebaseDbRepository instance = FirebaseDbRepository._();

  factory FirebaseDbRepository() {
    return instance;
  }
  FirebaseDbRepository._();

  late final _firestore = FirebaseFirestore.instance;
  late final _database = db.FirebaseDatabase.instance;

  Future getDocumentFromFirestore(String id, String collection) async {
    return (await _firestore.collection(collection).doc(id).get()).data();
  }

  Future getSubCollectionDocument({
    required String collection,
    required String documentId,
    required String subCollection,
    required String subColDocId,
  }) {
    return _firestore
        .collection(collection)
        .doc(documentId)
        .collection(subCollection)
        .doc(subColDocId)
        .get();
  }

  Future getAllSubCollectionDocuments({
    required String collection,
    required String documentId,
    required String subCollection,
  }) {
    return _firestore
        .collection(collection)
        .doc(documentId)
        .collection(subCollection)
        .get();
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> subscribeToDocument(
      String docId, String collection) {
    return _firestore.collection(collection).doc(docId).snapshots();
  }

  Future getDocumentFromRealtimeDb(String id, String path) async {
    return (await _database.ref().child(path).child(id).get()).value;
  }

  Future<List> getDocsFromRealtimeDb(List<String> ids, String path) async {
    final futures = ids.map((e) => getDocumentFromRealtimeDb(e, path));
    return Future.wait(futures);
  }

  Future updateFirebaseDocument(
    String collection,
    String docId, {
    required Map<String, Object?> data,
  }) async {
    await _firestore.collection(collection).doc(docId).update(data);
  }

  Future<List<ProductSnapshot>> getProducts({
    int? count,
    bool? isPopular,
    int? minPrice,
    int? maxPrice,
    String? size,
    String? category,
    String? subCategory,
    String? color,
    DocumentSnapshot? startAfter,
    SortBy sortBy = SortBy.popularity,
  }) async {
    final col = _firestore.collection(Db.productCol);

    Query<Map<String, dynamic>> query;

//Only Get Products Which Are In Stock
    query = col.where(Db.stockField, isEqualTo: true);

    ///No Longer Used
    ///
    // if (isPopular ?? false) {
    // query = query.where(Db.isPopularField, isEqualTo: true);
    // }
    //

    //Equal Queries
    if (category != null) {
      query = query.where(Db.categoryField, isEqualTo: category);
    }
    if (subCategory != null) {
      query = query.where(Db.subCategoryField, isEqualTo: subCategory);
    }

    //Sorting Queries
    if (minPrice != null) {
      query = query.where(Db.priceField, isGreaterThanOrEqualTo: minPrice);
    }
    if (maxPrice != null) {
      query = query.where(Db.priceField, isLessThanOrEqualTo: maxPrice);
    }

    final filterList = [];

    if (color != null) {
      filterList.add(color);
    }
    if (size != null) {
      filterList.add(size);
    }
    if (filterList.isNotEmpty) {
      query = query.where(Db.filtersField, arrayContainsAny: filterList);
    }

    ///Sorting Queries
    switch (sortBy) {
      case SortBy.popularity:
        query = query.orderBy(Db.popularityField);
        break;
      case SortBy.priceLTH:
        query = query.orderBy(Db.priceField);
        break;
      case SortBy.priceHTL:
        query = query.orderBy(Db.priceField, descending: true);
        break;
    }

    if (startAfter != null) {
      query = query.startAfterDocument(startAfter);
    }

    if (count != null) {
      query = query.limit(count);
    }

    final List<ProductSnapshot> list = [];
    final docs = await query.get();
    for (final doc in docs.docs) {
      final product = ProductModel.fromJson(doc.data());
      final snapshot = ProductSnapshot(product, doc);
      list.add(snapshot);
    }
    return list;
  }
}
