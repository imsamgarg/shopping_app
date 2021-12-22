import 'package:get/get.dart';
import 'package:shopping_app/app/core/utils/mixins/services_mixin.dart';
import 'package:shopping_app/app/core/values/values.dart';
import 'package:shopping_app/app/data/models/filter_map_model.dart';
import 'package:shopping_app/app/modules/product/controllers/products_list_controller.dart';
import 'package:shopping_app/app/modules/product/views/filter_view.dart';

class Filters {
  final String? color;
  final String? size;
  final double? minPrice;
  final double? maxPrice;
  final SortBy sortBy;

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
    filters ??= Filters(
      minPrice: filterMap.minPrice?.toDouble(),
      maxPrice: filterMap.maxPrice?.toDouble(),
    );

    Filters? result = await Get.bottomSheet(
      FilterBar(filters: filters!),
      isScrollControlled: true,
    );

    if (result != null) {
      filters = result;
      resetPaging();
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
