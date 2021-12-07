import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:shopping_app/app/core/utils/mixins.dart';
import 'package:shopping_app/app/data/models/app_model.dart';
import 'package:shopping_app/app/data/models/product_model.dart';

class HomeController extends GetxController with ServicesMixin {
  //Page Index
  final _index = 0.obs;
  get index => _index.value;
  set index(value) => _index.value = value;

  //
  AppModel? data;
  List<Offer> get offers => data?.offers ?? [];

  late final instance = _getData();

  late final PagingController<int, ProductSnapshot> pagingController;

  void onIndexChange(int p1) {
    if (data == null) return;
    index = p1;
  }

  @override
  void onInit() {
    pagingController = PagingController<int, ProductSnapshot>(firstPageKey: 0);
    pagingController.addPageRequestListener(_getPopularProducts);
    super.onInit();
  }

  @override
  void onClose() {
    pagingController.dispose();
    super.onClose();
  }

  Future<void> _getData() async {
    await userService.initUser();
    await configService.init();
    data = configService.data;
    return;
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
}
