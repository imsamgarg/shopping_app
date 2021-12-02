// import 'package:cloud_firestore/cloud_firestore.dart';

// import 'package:get/get.dart';

// class DatabaseService extends GetxService {
//   late FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
//   FirebaseFirestore get instance => this._firebaseFirestore;

//   Future<Profile> getProfile(String userId) async {
//     var data = await instance.collection(Db.profileCol).doc(userId).get();
//     if (data.data() != null) {
//       return Profile.fromJson(data.data()!);
//     } else {
//       throw Exception("No User Data Found");
//     }
//   }

//   Future<List<String>> getCategories() async {
//     var data = await instance.collection(Db.catCol).get();
//     if (data.docs.isEmpty) {
//       return List.empty();
//     }
//     return (data.docs[0].data()[Db.catField] as List).cast<String>();
//   }

//   Future<void> createProfile(String uid) async {
//     await instance.collection(Db.profileCol).doc(uid).set(Profile().toJson());
//     return;
//   }

//   Future<void> updateProfile(String uid, Profile profile) async {
//     await instance.collection(Db.profileCol).doc(uid).update(profile.toJson());
//     return;
//   }

//   Future<void> createPost(Post post) async {
//     await instance.collection(Db.postCol).add(post.toJson());
//     return;
//   }

//   Future<String> getWeatherKey() async {
//     final doc = await instance.collection(Db.keysCol).doc(Db.weatherDoc).get();
//     final data = doc.data();
//     if (!doc.exists) throw Exception("Key Not Found");
//     if (data == null) throw Exception("Key Not Found");
//     if ((data[Db.keyField] as String).isEmpty) throw Exception("Key Not Found");
//     return data[Db.keyField];
//   }

//   Future<QuerySnapshot> getPosts({
//     int? count,
//     DocumentSnapshot? startAfter,
//     String? uid,
//     String? category,
//   }) async {
//     var query = instance
//         .collection(Db.postCol)
//         .orderBy(Db.createdAtField, descending: true);
//     if (uid != null) {
//       query = query.where(Db.postUserField, isEqualTo: uid);
//     }
//     if (category != null) {
//       query = query.where(Db.postCatField, isEqualTo: category);
//     }
//     if (startAfter != null) {
//       query = query.startAfterDocument(startAfter);
//     }
//     if (count != null) {
//       query = query.limit(count);
//     }
//     return await query.get();
//   }

//   Future<QuerySnapshot> getComments({
//     int? count,
//     DocumentSnapshot? startAfter,
//     required String postId,
//   }) async {
//     var query = instance
//         .collection(Db.postCol)
//         .doc(postId)
//         .collection(Db.commentsCol)
//         .orderBy(Db.createdAtField, descending: true);
//     // if (uid != null) query.where(Db.postUserField, isEqualTo: uid);
//     // if (category != null) query.where(Db.postCatField, isEqualTo: category);
//     if (startAfter != null) {
//       query = query.startAfterDocument(startAfter);
//     }
//     if (count != null) {
//       query = query.limit(count);
//     }
//     return await query.get();
//   }

//   Future<void> postComment({
//     required String uid,
//     required String content,
//     required String postId,
//     required String userName,
//     required String profileImage,
//   }) async {
//     final comment = Comment(
//       createdAt: Timestamp.now(),
//       text: content,
//       profileImage: profileImage,
//       userName: userName,
//       userId: uid,
//     );

//     await instance
//         .collection(Db.postCol)
//         .doc(postId)
//         .collection(Db.commentsCol)
//         .add(comment.toJson());

//     await instance
//         .collection(Db.postCol)
//         .doc(postId)
//         .update({Db.commentsCountField: FieldValue.increment(1)});
//   }

//   Future<void> likePost({
//     required String uid,
//     required String postId,
//   }) async {
//     final like = Like(
//       createdAt: Timestamp.now(),
//       user: uid,
//     );

//     await instance
//         .collection(Db.postCol)
//         .doc(postId)
//         .collection(Db.likesCol)
//         .add(like.toJson());

//     await instance
//         .collection(Db.postCol)
//         .doc(postId)
//         .update({Db.likesCountField: FieldValue.increment(1)});
//   }

//   // TODO: implement dislike post
//   // Future<void> dislikePost({
//   //   required String uid,
//   //   required String postId,
//   // }) async {
//   //   await instance.collection(Db.postCol).doc(postId).collection(Db.likesCol).;

//   //   await instance
//   //       .collection(Db.postCol)
//   //       .doc(postId)
//   //       .update({Db.likesCountField: FieldValue.increment(-1)});
//   // }

//   // Future<List<Comment>> getComments(String postId) async {
//   //   final data = await instance
//   //       .collection(Db.postCol)
//   //       .doc(postId)
//   //       .collection(Db.commentsCol)
//   //       .orderBy(Db.createdAtField)
//   //       .get();
//   //   return data.docs.map((e) => Comment.fromJson(e.data())).toList();
//   // }
// }
