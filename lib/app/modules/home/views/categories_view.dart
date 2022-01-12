import 'package:custom_utils/log_utils.dart';
import 'package:custom_utils/spacing_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/app/core/global_widgets/cached_image.dart';
import 'package:shopping_app/app/core/global_widgets/category_card.dart';
import 'package:shopping_app/app/core/theme/sizing_theme.dart';
import 'package:shopping_app/app/core/values/values.dart';
import 'package:shopping_app/app/data/models/category_model.dart';
import 'package:shopping_app/app/modules/home/controllers/home_controller.dart';

class CategoriesView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    final categories = controller.cats;

    final categoryTabs = categories.map((e) => Tab(text: e.name)).toList();
    final categoryViews = categories.map((e) => _SubCategoryView(e)).toList();

    return DefaultTabController(
      length: categories.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Categories"),
          bottom: TabBar(tabs: categoryTabs),
        ),
        body: TabBarView(children: categoryViews),
      ),
    );
  }
}

class _SubCategoryView extends GetView<HomeController> {
  final Category category;
  const _SubCategoryView(this.category);

  bool checkCondition(SubCategory subCategory) {
    return subCategory.category == category.name;
  }

  @override
  Widget build(BuildContext context) {
    final subCategories = controller.subCats.where(checkCondition).toList();
    customLog(category.img!);
    return Padding(
      padding: Sizing.sidePadding,
      child: Column(
        children: [
          verSpacing12,
          if (category.img != null)
            SizedBox(
              height: 150,
              child: _CategoryImage(image: category.img!),
            ),
          verSpacing24,
          Expanded(
            child: GridView.builder(
              itemCount: subCategories.length,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: kProductWidth,
                mainAxisSpacing: 10,
                mainAxisExtent: kProductHeight - 30,
                crossAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                return SubCategoryCard(subCategory: subCategories[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryImage extends StatelessWidget {
  final String image;

  const _CategoryImage({Key? key, required this.image}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CachedImage(
      url: image,
      boxFit: BoxFit.cover,
      borderRadius: Sizing.borderRadiusXLL,
    );
  }
}
