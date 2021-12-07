import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:shopping_app/app/core/utils/mixins.dart';

class FavouriteController extends GetxController with ServicesMixin {
  static const _fetchCount = 10;
  late final pagingController = PagingController(firstPageKey: 0)
    ..addPageRequestListener((pageKey) {
      fetchProducts(pageKey);
    });

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
}
