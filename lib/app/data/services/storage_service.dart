import 'dart:io';
import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:shopping_app/app/data/repository/cloud_storage_repository.dart';
import 'package:shopping_app/app/data/repository/storage_repository.dart';

class StorageService extends GetxService {
  static StorageService service() => Get.find<StorageService>();
  late final _cloudStorageRepo = FirebaseStorageRepository();
  late final _storageRepo = StorageRepository();

  Future<String> uploadFile({
    required String fileName,
    required String folderName,
    required String path,
  }) {
    return _cloudStorageRepo.uploadFile(
      fileName: fileName,
      folderName: folderName,
      path: path,
    );
  }

  Future<Uint8List?> downloadFile(String path) {
    return _cloudStorageRepo.downloadFile(path);
  }

  Future<File> saveFileToCache(Uint8List data, String fileName) {
    return _storageRepo.saveFileToCache(data, fileName);
  }

  Future<String?> getCacheFilePathIfExists(String fileName) {
    return _storageRepo.getCacheFilePathIfExists(fileName);
  }
}
