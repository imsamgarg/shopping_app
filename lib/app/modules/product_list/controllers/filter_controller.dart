import 'package:get/get.dart';

import 'package:shopping_app/app/core/utils/mixins/services_mixin.dart';
import 'package:shopping_app/app/core/values/values.dart';
import 'package:shopping_app/app/data/models/filter_map_model.dart';
import 'package:shopping_app/app/modules/product_list/controllers/products_list_controller.dart';
import 'package:shopping_app/app/modules/product_list/views/filter_view.dart';

class Filters {
  String? color;
  String? size;
  double? minPrice;
  double? maxPrice;
  SortBy sortBy;

  Filters({
    this.color,
    this.size,
    this.minPrice,
    this.maxPrice,
    this.sortBy = SortBy.popularity,
  });
}

class FilterController extends GetxController with ServicesMixin {
  late final FilterMap filterMap;
  late final _productsController = Get.find<ProductsListController>();
  late Future<bool> instance = _getFilterMap();

  Filters? filters;

  void resetPaging() {
    _productsController.resetPaging();
  }

  void onFilterTap() async {
    filters ??= Filters();

    filters!.minPrice = filterMap.minPrice?.toDouble();
    filters!.maxPrice = filterMap.maxPrice?.toDouble();

    final result = await Get.bottomSheet(
      FilterBar(filters: filters!),
      isScrollControlled: true,
    );

    if (result is bool && result == false) {
      filters = null;
      return resetPaging();
    }

    if (result != null && result is Filters) {
      filters = result;
      return resetPaging();
    }
  }

  Future<bool> _getFilterMap() async {
    final model = _productsController.model;
    final category = model.category;
    final subCategory = model.subCategory;
    filterMap = await productsService.getFilter("$category-$subCategory");
    return true;
  }
}
