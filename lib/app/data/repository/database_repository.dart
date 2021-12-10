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
    DocumentSnapshot? startAfter,
    bool? isPopular,
    int? minPrice,
    int? maxPrice,
    String? size,
    String? color,
    SortBy sortBy = SortBy.popularity,
  }) async {
    CollectionReference<Map<String, dynamic>> col =
        _firestore.collection(Db.productCol);

    Query<Map<String, dynamic>> query;

    switch (sortBy) {
      case SortBy.popularity:
        query = col.orderBy(Db.popularityField);
        break;
      case SortBy.priceLTH:
        query = col.orderBy(Db.priceField);
        break;
      case SortBy.priceHTL:
        query = col.orderBy(Db.priceField, descending: true);
        break;
    }

    query = query.where(Db.stockField, isEqualTo: true);

    if (isPopular ?? false) {
      query = query.where(Db.isPopularField, isEqualTo: true);
    }
    if (minPrice != null) {
      query = query.where(Db.priceField, isGreaterThanOrEqualTo: minPrice);
    }
    if (maxPrice != null) {
      query = query.where(Db.priceField, isLessThanOrEqualTo: minPrice);
    }
    if (startAfter != null) {
      query = query.startAfterDocument(startAfter);
    }
    if (size != null) {
      query = query.where("${Db.sizeField}.$size", isNull: false);
    }
    if (color != null) {
      query = query.where("${Db.colorField}.$color", isNull: false);
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
