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
  List<AppBanner> get offers => data?.banners ?? [];

  late final Future<bool> instance = _getData();

  late final cats = data?.categories.map((e) => e.name ?? "").toList() ?? [];
  late final subCats = _getSubCatList();

  void onIndexChange(int p1) {
    if (data == null) return;
    index = p1;
  }

  Future<bool> _getData() async {
    await userService.initUser();
    await configService.init();
    data = configService.data;
    1.delay().then((_) => linkService.handleDynamicLink());
    return true;
  }

  void onCartTap() {}

  List<String?> _getSubCatList() {
    final list = <String?>[];
    for (final cat in data!.categories) {
      for (var subCat in cat.subCats!) {
        list.add(subCat.name);
      }
    }
    return list;
  }
}
