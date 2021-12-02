// import 'package:shopping_app/app/core/interfaces.dart';

// class CloudStorageRepository extends StorageInterface {
//   const CloudStorageRepository();

//   FirebaseS
//   Future<String> saveProfileImage(String path, String uid) async {
//     final ext = p.extension(path);
//     final ref = storage.child(profileRef).child("$uid$ext");
//     final res = await ref.putFile(File(path));
//     return await res.ref.getDownloadURL();
//   }

//   @override
//   Future<String> saveImage(String imageUrl) {}
// }
