import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:shopping_app/app/core/utils/mixins/routes_mixin.dart';

import 'package:shopping_app/app/core/utils/mixins/services_mixin.dart';
import 'package:shopping_app/app/core/values/values.dart';
import 'package:shopping_app/app/data/models/product_model.dart';

import 'filter_controller.dart';

class ProductsListController extends GetxController
    with ServicesMixin, RoutesMixin {
  late final PagingController<int, ProductSnapshot> pagingController;
  late final filterController = Get.find<FilterController>();
  late final model = Get.arguments as ProductQueryModel;

  String get title {
    return model.isPopular ?? false
        ? "Popular Products"
        : model.subCategory?.capitalize ?? "";
  }

  @override
  void onInit() {
    pagingController = PagingController<int, ProductSnapshot>(firstPageKey: 0);
    pagingController.addPageRequestListener(_getPopularProducts);
    super.onInit();
  }

  Future<void> _getPopularProducts(int pageKey) async {
    QueryDocumentSnapshot<Map<String, dynamic>>? snapshots;
    if (pageKey != 0) {
      snapshots = pagingController.value.itemList?.last.snapshot;
    }

    final size = filterController.filters?.size;
    final color = filterController.filters?.color;
    final maxPrice = filterController.filters?.maxPrice?.toInt();
    final minPrice = filterController.filters?.minPrice?.toInt();
    final sortBy = filterController.filters?.sortBy;

    final docs = await productsService.getProducts(
      startAfter: snapshots,
      size: size,
      color: color,
      category: model.category,
      subCategory: model.subCategory,
      maxPrice: maxPrice,
      sortBy: sortBy ?? SortBy.popularity,
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
