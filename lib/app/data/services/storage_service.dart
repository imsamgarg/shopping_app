import 'dart:io';
import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:path/path.dart' as p;
import 'package:shopping_app/app/data/repository/cloud_storage_repository.dart';
import 'package:shopping_app/app/data/repository/storage_repository.dart';

class StorageService extends GetxService {
  static StorageService service() => Get.find<StorageService>();
  late final _cloudStorageRepo = FirebaseStorageRepository();
  late final _storageRepo = StorageRepository();

  final String imageFolderName = "images";

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

  Future<Uint8List?> downloadImage(String url) {
    return _cloudStorageRepo.downloadFile(url);
  }

  Future<File> saveProductImageToCache(Uint8List data, String name) async {
    await _storageRepo.createSubCacheDirectory(imageFolderName);
    final fullPath = p.join(imageFolderName, name);
    return _storageRepo.saveFileToCache(data, fullPath);
  }

  Future<String?> getImage(String id, String imageUrl) async {
    final cachePath = await _storageRepo.getCacheDirectory();
    final filePath = p.join(cachePath.path, imageFolderName, "$id.png");

    final isFileExist = await File(filePath).exists();
    if (isFileExist) return filePath;

    final image = await downloadImage(imageUrl);
    if (image == null) {
      return null;
    }

    final localImageFile = await saveProductImageToCache(image, "$id.jpg");

    return localImageFile.path;
  }
}
