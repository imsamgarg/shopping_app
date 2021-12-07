import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:shopping_app/app/core/utils/mixins.dart';
import 'package:shopping_app/app/data/models/product_model.dart';

class FavouriteController extends GetxController with ServicesMixin {
  static const _fetchCount = 10;
  late final PagingController<int, ProductModel> pagingController;

  @override
  void onInit() {
    pagingController = PagingController<int, ProductModel>(firstPageKey: 0);
    pagingController.addPageRequestListener(fetchProducts);
    super.onInit();
  }

  @override
  void onClose() {
    pagingController.dispose();
    super.onClose();
  }

  Future<void> fetchProducts(int pageKey) async {
    final products = await userService.getFavouriteProducts(
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

  void removeFavouriteProduct([int? index, String? id]) {
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
}
