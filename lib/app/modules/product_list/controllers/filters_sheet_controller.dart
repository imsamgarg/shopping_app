import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/app/core/values/values.dart';

import 'filter_controller.dart';

class FiltersSheetController extends GetxController {
  final Filters filters;

  FiltersSheetController(this.filters);

  late final controller = Get.find<FilterController>();
  late final size = RxnString(filters.size);
  late final color = RxnString(filters.color);
  late final minPrice = RxnDouble(filters.minPrice);
  late final maxPrice = RxnDouble(filters.maxPrice);
  late final sortBy = SortBy.popularity.obs;
  late final showPopularity = true.obs;

  late final priceRange = RangeValues(filters.minPrice!, filters.maxPrice!).obs;

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
    minPrice.value = value.start.round().toDouble();
    maxPrice.value = value.end.round().toDouble();
    priceRange.value = value;

    changePopularityVisibility(value);
    changeSorting(SortBy.priceLTH);
  }

  void changePopularityVisibility(RangeValues value) {
    if (filters.minPrice == value.start) {
      if (filters.maxPrice == value.end) {
        showPopularity.value = true;
        return;
      }
    }
    showPopularity.value = false;
  }

  void onSaveFilterTap() {
    populateFilters();

    Get.back(result: filters);
  }

  void populateFilters() {
    if (filters.minPrice != minPrice.value) {
      filters.minPrice = minPrice.value;
      filters.maxPrice = maxPrice.value;
    } else {
      filters.minPrice = null;
    }

    if (filters.maxPrice != maxPrice.value) {
      filters.maxPrice = maxPrice.value;
      filters.minPrice = minPrice.value;
    } else {
      filters.maxPrice = null;
    }

    filters.color = color.value;
    filters.size = size.value;
    filters.sortBy = sortBy.value;
  }

  void onClearFilters() {
    Get.back(result: false);
  }
}
