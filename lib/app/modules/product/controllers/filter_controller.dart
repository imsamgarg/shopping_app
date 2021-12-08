import 'package:get/get.dart';
import 'package:shopping_app/app/core/utils/mixins/services_mixin.dart';
import 'package:shopping_app/app/data/models/filter_map_model.dart';
import 'package:shopping_app/app/modules/product/controllers/products_list_controller.dart';

class FilterController extends GetxController with ServicesMixin {
  late final FilterMap filters;
  late final _productsController = Get.find<ProductsListController>();
  late Future<void> instance = _getFilterMap();

  final size = RxnString();
  final color = RxnString();
  final minPrice = RxnInt();
  final maxPrice = RxnInt();

  void onSaveTap() {
    _productsController.resetPaging();
  }

  void onFilterTap() {}

  Future<void> _getFilterMap() async {
    String name = _productsController.id;
    filters = await productsService.getFilter(name);
    return;
  }
}
