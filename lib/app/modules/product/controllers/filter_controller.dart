import 'package:get/get.dart';
import 'package:shopping_app/app/core/utils/mixins/services_mixin.dart';
import 'package:shopping_app/app/core/values/values.dart';
import 'package:shopping_app/app/data/models/filter_map_model.dart';
import 'package:shopping_app/app/modules/product/controllers/products_list_controller.dart';

class FilterController extends GetxController with ServicesMixin {
  late final FilterMap filters;
  late final _productsController = Get.find<ProductsListController>();
  late Future<bool> instance = _getFilterMap();

  final size = RxnString();
  final color = RxnString();
  final minPrice = RxnInt();
  final maxPrice = RxnInt();
  final sortBy = SortBy.popularity.obs;

  void onSaveTap() {
    _productsController.resetPaging();
  }

  void onFilterTap() {}

  Future<bool> _getFilterMap() async {
    final model = _productsController.model;
    // TODO: change krna enu $cat/$subCat ch
    filters = await productsService.getFilter(model.subCategory ?? "");
    return true;
  }
}
