import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as p;

import 'package:shopping_app/app/core/interfaces.dart';

class FirebaseStorageRepository extends CloudStorageInterface {
  FirebaseStorageRepository._();

  static final instance = FirebaseStorageRepository._();

  factory FirebaseStorageRepository() {
    return instance;
  }

  late final _storage = FirebaseStorage.instance;
  late final _rootRef = _storage.ref();

  @override
  Future<String> uploadFile({
    required String path,
    required String fileName,
    required String folderName,
  }) async {
    final extension = p.extension(path);
    final ref = _rootRef.child(folderName).child("$fileName$extension");
    return (await ref.putFile(File(path))).ref.fullPath;
  }

  @override
  Future<Uint8List?> downloadFile(String path) async {
    final ref = _rootRef.child(path);
    return ref.getData();
  }
}
