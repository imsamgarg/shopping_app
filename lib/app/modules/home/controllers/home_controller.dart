import 'package:get/get.dart';

import 'package:shopping_app/app/core/utils/mixins/routes_mixin.dart';
import 'package:shopping_app/app/core/utils/mixins/services_mixin.dart';
import 'package:shopping_app/app/data/models/app_model.dart';

class HomeController extends GetxController with ServicesMixin, RoutesMixin {
  //Page Index
  final _index = 0.obs;
  get index => _index.value;
  set index(value) => _index.value = value;

  //
  AppModel? data;

  late final offers = data?.banners ?? [];

  late final Future<bool> instance = _getData();

  late final cats = data?.categories ?? [];

  late final subCats = data?.subCategories ?? [];

  void onIndexChange(int p1) {
    if (data == null) return;
    index = p1;
  }

  void setHomeView() {
    index = 0;
  }

  Future<bool> onBackPress() async {
    if (index == 0) {
      return true;
    }

    index = 0;
    return false;
  }

  Future<bool> _getData() async {
    await Future.wait([userService.initUser(), configService.initService()]);

    data = configService.data;
    1.delay().then((_) => linkService.handleDynamicLink());
    return true;
  }
}
