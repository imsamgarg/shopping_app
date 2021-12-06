import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart' as db;
import 'package:shopping_app/app/core/values/db_strings.dart';
import 'package:shopping_app/app/core/values/values.dart';
import 'package:shopping_app/app/data/models/product_model.dart';

class FirebaseDbRepository {
  static final FirebaseDbRepository instance = FirebaseDbRepository();

  factory FirebaseDbRepository() {
    return instance;
  }
  late final _firestore = FirebaseFirestore.instance;
  late final _database = db.FirebaseDatabase.instance;

  Future getDocumentFromFirestore(String id, String collection) async {
    return (await _firestore.collection(collection).doc(id).get()).data();
  }

  Future getDocumentFromRealtimeDb(String id, String path) async {
    return (await _database.reference().child(path).child(id).get()).value;
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

  Future<List<ProductModel>> getProducts({
    int? count,
    DocumentSnapshot? startAfter,
    bool? isPopular,
    SortBy sortBy = SortBy.popularity,
  }) async {
    Query<Map<String, dynamic>> query;
    switch (sortBy) {
      case SortBy.popularity:
        query =
            _firestore.collection(Db.productCol).orderBy(Db.popularityField);
        break;
      case SortBy.priceLTH:
        query = _firestore.collection(Db.productCol).orderBy(Db.priceField);
        break;
      case SortBy.priceHTL:
        query = _firestore.collection(Db.productCol).orderBy(
              Db.priceField,
              descending: true,
            );
        break;
    }
    if (isPopular ?? false) {
      query = query.where(Db.isPopularField, isEqualTo: true);
    }
    if (startAfter != null) {
      query = query.startAfterDocument(startAfter);
    }
    if (count != null) {
      query = query.limit(count);
    }
    return (await query.get())
        .docs
        .map((e) => ProductModel.fromJson(e.data()))
        .toList();
  }
}
