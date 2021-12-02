// import 'dart:io';

// import 'package:get/get.dart';
// import 'package:path/path.dart' as p;

// class CloudStorageService extends GetxService {
//   FirebaseStorage _storage = FirebaseStorage.instance;

//   Reference get storage => _storage.ref();

//   Future<String> saveProfileImage(String path, String uid) async {
//     final ext = p.extension(path);
//     final ref = storage.child(profileRef).child("$uid$ext");
//     final res = await ref.putFile(File(path));
//     return await res.ref.getDownloadURL();
//   }

//   Future<String> savePostImage(String path, String uid) async {
//     final ext = p.extension(path);
//     final time = DateTime.now().millisecondsSinceEpoch;
//     final ref = storage.child(postRef).child("$uid$time$ext");
//     final res = await ref.putFile(File(path));
//     return await res.ref.getDownloadURL();
//   }
// }
