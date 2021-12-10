import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:shopping_app/app/core/utils/mixins/routes_mixin.dart';
import 'package:shopping_app/app/core/utils/mixins/services_mixin.dart';
import 'package:shopping_app/app/data/models/app_model.dart';
import 'package:shopping_app/app/data/models/product_model.dart';

class HomeController extends GetxController with ServicesMixin, RoutesMixin {
  //Page Index
  final _index = 0.obs;
  get index => _index.value;
  set index(value) => _index.value = value;

  //
  AppModel? data;
  List<Offer> get offers => data?.offers ?? [];

  late final Future<bool> instance = _getData();

  late final PagingController<int, ProductSnapshot> pagingController;

  late final cats = data?.categories.map((e) => e.name ?? "").toList() ?? [];
  late final subCats = _getSubCatList();

  void onIndexChange(int p1) {
    if (data == null) return;
    index = p1;
  }

  @override
  void onInit() {
    pagingController = PagingController<int, ProductSnapshot>(firstPageKey: 0);
    super.onInit();
  }

  @override
  void onClose() {
    pagingController.dispose();
    super.onClose();
  }

  Future<bool> _getData() async {
    await userService.initUser();
    await configService.init();
    data = configService.data;
    pagingController.addPageRequestListener(_getPopularProducts);
    1.delay().then((_) => linkService.handleLink());
    return true;
  }

  Future<void> _getPopularProducts(int pageKey) async {
    QueryDocumentSnapshot<Map<String, dynamic>>? snapshots;
    if (pageKey != 0) {
      snapshots = pagingController.value.itemList?.last.snapshot;
    }
    final docs = await productsService.getPopularProducts(
      startAfter: snapshots,
    );
    if (docs.length < pageKey) {
      pagingController.appendLastPage(docs);
    } else {
      pagingController.appendPage(docs, pageKey + docs.length);
    }
  }

  void logout() async {
    (await userService.logout());
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
