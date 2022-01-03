import 'package:get/get.dart';

import 'package:shopping_app/app/core/values/db_strings.dart';
import 'package:shopping_app/app/data/models/app_model.dart';
import 'package:shopping_app/app/data/repository/database_repository.dart';

class ConfigService extends GetxService {
  late final _repo = FirebaseDbRepository();
  static ConfigService service() => Get.find<ConfigService>();
  // final Rxn<AppModel?> _data = Rxn<AppModel>(null);
  // AppModel? get data => _data.value;
  // set data(value) => _data.value = value;

  AppModel? data;
  Future<void> init() async {
    if (data == null) {
      await _getData();
      // _subscribeData();
    }
    return;
  }

  // void _subscribeData() {
  //   _repo.subscribeToDocument(Db.configDocument, Db.configCol).listen(
  //     (event) {
  //       final doc = event.data();
  //       data = AppModel.fromJson(doc);
  //     },
  //   );
  // }

  Future<void> _getData() async {
    final doc = await _repo.getDocumentFromFirestore(
      Db.configDocument,
      Db.configCol,
    );
    data = AppModel.fromJson(doc);
    return;
  }
}
