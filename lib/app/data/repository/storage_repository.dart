import 'dart:io';
import 'dart:typed_data';

import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as path_provider;

class StorageRepository {
  StorageRepository._();

  static final instance = StorageRepository._();

  factory StorageRepository() {
    return instance;
  }

  Future<File> saveFileToCache(Uint8List data, String filePath) async {
    final cacheDir = await getCacheDirectory();
    final fullFilePath = path.join(cacheDir.path, filePath);
    return (await File(fullFilePath).writeAsBytes(data));
  }

  Future<Directory> getCacheDirectory() {
    return path_provider.getApplicationDocumentsDirectory();
  }

  Future<Directory> createSubCacheDirectory(String folderName) async {
    final cacheDir = await getCacheDirectory();
    final folderPath = path.join(cacheDir.path, folderName);
    return await Directory(folderPath).create(recursive: true);
  }
}
