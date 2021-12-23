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

  Future<File> saveFileToCache(Uint8List data, String fileName) async {
    final cacheDir = await _getCacheDirectory();
    final filePath = path.join(cacheDir.path, fileName);
    return (await File(filePath).writeAsBytes(data));
  }

  Future<bool> isFileExistInCache(String fileName) async {
    final cacheDir = await _getCacheDirectory();
    final filePath = path.join(cacheDir.path, fileName);
    return (await File(filePath).exists());
  }

  Future<String?> getCacheFilePathIfExists(String fileName) async {
    final isExist = await isFileExistInCache(fileName);
    if (!isExist) return null;

    final cacheDir = await _getCacheDirectory();
    final filePath = path.join(cacheDir.path, fileName);
    return filePath;
  }

  Future<Directory> _getCacheDirectory() {
    return path_provider.getApplicationDocumentsDirectory();
  }
}
