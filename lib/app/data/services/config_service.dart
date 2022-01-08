import 'package:get/get.dart';

import 'package:shopping_app/app/core/values/db_strings.dart';
import 'package:shopping_app/app/data/models/app_model.dart';
import 'package:shopping_app/app/data/repository/database_repository.dart';

class ConfigService extends GetxService {
  late final _repo = FirebaseDbRepository();
  static ConfigService service() => Get.find<ConfigService>();

  AppModel? data;
  Future<ConfigService> initService() async {
    if (data == null) {
      await _getData();
    }
    return this;
  }

  Future getDoc(String docId) {
    return _repo.getDocumentFromFirestore(docId, Db.configCol);
  }

  Future<void> _getData() async {
    // final _data = await Future.wait([
    //   getDoc(Db.bannerDoc),
    //   getDoc(Db.categoriesDoc),
    //   getDoc(Db.subCategoriesDoc),
    //   getDoc(Db.deliveryConfigDoc),
    // ]);

    // data = AppModel();

    final doc = await getDoc(Db.configDocument);

    data = AppModel.fromJson(doc);

    // data!.banners = (_data[0] as List?)?.map((e) {
    //   return AppBanner.fromJson(e);
    // }).toList();

    // data!.categories = (_data[1] as List?)?.map((e) {
    //   return Category.fromJson(e);
    // }).toList();

    // data!.subCategories = (_data[2] as List?)?.map((e) {
    //   return SubCategory.fromJson(e);
    // }).toList();

    // data!.deliveryConfig = DeliveryConfiguration.fromJson(_data[3]);

    return;
  }
}
