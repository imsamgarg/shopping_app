import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:shopping_app/app/core/utils/mixins/services_mixin.dart';
import 'package:shopping_app/app/data/models/product_model.dart';
import 'package:shopping_app/app/modules/product/controllers/filter_controller.dart';

class ProductsListController extends GetxController with ServicesMixin {
  late final PagingController<int, ProductSnapshot> pagingController;
  late final filterController = Get.find<FilterController>();
  late final id = Get.arguments;

  @override
  void onInit() {
    pagingController = PagingController<int, ProductSnapshot>(firstPageKey: 0);
    pagingController.addPageRequestListener(_getPopularProducts);
    super.onInit();
  }

  Future<void> _getPopularProducts(int pageKey) async {
    final size = filterController.size.value;
    final color = filterController.color.value;
    final maxPrice = filterController.maxPrice.value;
    final minPrice = filterController.minPrice.value;

    QueryDocumentSnapshot<Map<String, dynamic>>? snapshots;
    if (pageKey != 0) {
      snapshots = pagingController.value.itemList?.last.snapshot;
    }
    final docs = await productsService.getProducts(
      startAfter: snapshots,
      size: size,
      color: color,
      maxPrice: maxPrice,
      minPrice: minPrice,
    );
    if (docs.length < pageKey) {
      pagingController.appendLastPage(docs);
    } else {
      pagingController.appendPage(docs, pageKey + docs.length);
    }
  }

  void resetPaging() {
    pagingController.refresh();
  }
}
