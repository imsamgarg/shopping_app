import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'package:shopping_app/app/core/utils/mixins/routes_mixin.dart';
import 'package:shopping_app/app/core/utils/mixins/services_mixin.dart';
import 'package:shopping_app/app/data/models/product_model.dart';

class PopularProductsController extends GetxController
    with ServicesMixin, RoutesMixin {
  late final PagingController<int, ProductSnapshot> pagingController;

  @override
  void onInit() {
    pagingController = PagingController<int, ProductSnapshot>(firstPageKey: 0);
    pagingController.addPageRequestListener(_getPopularProducts);
    super.onInit();
  }

  @override
  void onClose() {
    pagingController.dispose();
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
