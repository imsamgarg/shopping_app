import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/app/core/values/values.dart';
import 'package:shopping_app/app/modules/product/controllers/filter_controller.dart';

class FiltersSheetController extends GetxController {
  final Filters filters;

  FiltersSheetController(this.filters);

  late final controller = Get.find<FilterController>();
  late final size = RxnString(filters.size);
  late final color = RxnString(filters.color);
  late final minPrice = RxnDouble(filters.minPrice);
  late final maxPrice = RxnDouble(filters.maxPrice);
  late final sortBy = SortBy.popularity.obs;

  Rx<RangeValues>? priceRange;

  List<String> get sizeList => controller.filterMap.size ?? <String>[];
  List<String> get colorList => controller.filterMap.color ?? <String>[];

  void changeSorting(SortBy _sortBy) {
    sortBy.value = _sortBy;
  }

  void changeSelectedSize(String _size) {
    size.value = _size;
  }

  void changeSelectedColor(String _color) {
    color.value = _color;
  }

  void onPriceChange(RangeValues value) {
    minPrice.value = value.start;
    maxPrice.value = value.end;
    priceRange!.value = value;
  }

  void onSaveFilterTap() {
    Get.back(result: filters);
  }
}
