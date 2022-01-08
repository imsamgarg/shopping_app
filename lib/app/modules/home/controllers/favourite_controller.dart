import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'package:shopping_app/app/core/utils/mixins/services_mixin.dart';
import 'package:shopping_app/app/data/models/product_model.dart';
import 'package:shopping_app/app/modules/home/controllers/home_controller.dart';

typedef FavouritePageController = PagingController<int, ProductModel>;

class FavouriteController extends GetxController with ServicesMixin {
  static const _fetchCount = 10;
  late final FavouritePageController pagingController = _getController();
  late final homeController = Get.find<HomeController>();

  late final instance = _getFavourites();
  @override
  void onClose() {
    pagingController.dispose();
    super.onClose();
  }

  Future<void> fetchProducts(int pageKey) async {
    final products = await favouriteService.getFavouriteProducts(
      pageKey,
      pageKey + _fetchCount,
    );
    final isLast = products.length < _fetchCount;
    if (isLast) {
      pagingController.appendLastPage(products);
    } else {
      pagingController.appendPage(products, pageKey + products.length);
    }
  }

  void addFavouriteProduct(ProductModel product) {
    final list = pagingController.value.itemList ?? [];
    final newList = [product, ...list];
    pagingController.value = PagingState(
      itemList: newList,
      nextPageKey: newList.length,
    );
  }

  void removeFavouriteProduct({int? index, String? id}) {
    final list = pagingController.value.itemList ?? [];
    if (index != null) {
      list.removeAt(index);
    } else {
      list.removeWhere((p) => p.id == id);
    }
    pagingController.value = PagingState(
      itemList: list,
      nextPageKey: list.length,
    );
  }

  void onBackPress() {
    homeController.setHomeView();
  }

  FavouritePageController _getController() {
    final _pagingController = FavouritePageController(firstPageKey: 0);
    _pagingController.addPageRequestListener(fetchProducts);

    return _pagingController;
  }

  Future<bool> _getFavourites() async {
    await favouriteService.initService();
    return true;
  }
}
