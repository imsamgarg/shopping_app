import 'package:flutter/material.dart';

import 'package:custom_utils/spacing_utils.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:shopping_app/app/core/global_widgets/buttons.dart';
import 'package:shopping_app/app/core/global_widgets/cached_image.dart';
import 'package:shopping_app/app/core/global_widgets/future_builder.dart';
import 'package:shopping_app/app/core/global_widgets/navbar.dart';
import 'package:shopping_app/app/core/global_widgets/product.dart';
import 'package:shopping_app/app/core/utils/helper.dart';
import 'package:shopping_app/app/core/values/values.dart';
import 'package:shopping_app/app/data/models/app_model.dart';
import 'package:shopping_app/app/data/models/product_model.dart' as p;
import 'package:shopping_app/app/modules/home/controllers/popular_products_controller.dart';
import 'package:shopping_app/app/modules/home/views/favourite_view.dart';
import 'package:shopping_app/app/modules/home/views/profile_view.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return AppFutureBuilder(
      builder: (data) {
        return Scaffold(
          bottomNavigationBar: AppNavbar(
            onIndexChange: controller.onIndexChange,
          ),
          body: Obx(
            () => IndexedStack(
              index: controller.index,
              children: [
                const _HomeView(),
                FavouriteView(),
                ProfileView(),
              ],
            ),
          ),
        );
      },
      future: controller.instance,
    );
  }
}

class _HomeView extends GetView<HomeController> {
  const _HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          _AppBar(),
          // _Heading(),
          if (controller.data?.banners.isNotEmpty ?? false) ...[
            verSliverSpacing16,
            const _Banners(),
            verSliverSpacing16,
          ],
          // _Categories(),
          // verSliverSpacing8,
          _SubHeading(
            heading: 'Categories',
            onTap: controller.onAllCategoriesTap,
          ),
          _SubCategories(),
          verSliverSpacing8,
          _SubHeading(
            heading: 'Popular Products',
            onTap: () => controller.onSubCategoryTap(isPopular: true),
          ),
          _PopularProduct(),
        ],
      ).px16(),
    );
  }
}

class _PopularProduct extends GetView<PopularProductsController> {
  @override
  Widget build(BuildContext context) {
    return PagedSliverGrid<int, p.ProductSnapshot>(
      pagingController: controller.pagingController,
      builderDelegate: PagedChildBuilderDelegate(
        itemBuilder: (_, item, i) {
          return ProductCard(product: item.product);
        },
      ),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: productWidth,
        mainAxisSpacing: 10,
        mainAxisExtent: productHeight,
        crossAxisSpacing: 10,
      ),
    );
  }
}

class _SubHeading extends StatelessWidget {
  final String heading;
  final VoidCallback? onTap;

  const _SubHeading({Key? key, required this.heading, this.onTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          heading.text.semiBold.color(const Color(0xff14284a)).size(18).make(),
          AppTextButton(
            onTap: onTap ?? () {},
            child: "See All".text.bold.make(),
            color: Vx.white,
            foregroundColor: primaryColor(context),
          )
        ],
      ).py8(),
    );
  }
}

class _SubCategories extends GetView<HomeController> {
  // final colors = [
  //   Color(0xFF6B2A5F),
  //   Colors.blue,
  //   Colors.green,
  // Colors.accents
  // Color(0xFFF7D9C4),
  // Color(0xFF903A73),
  // Color(0xFFFFF0E6),
  //   // Color(0xFFB44C78),
  //   Color(0xFFF9AC9D),
  //   // Color(0xFFFFCEB8),
  //   // Color(0xFFFF7079),
  //   // Color(0xFFFFB190),
  //   Color(0xFFE56189),
  // ];
  final colors = [
    Colors.redAccent,
    Colors.pinkAccent,
    Colors.deepPurpleAccent,
    Colors.indigoAccent,
    Colors.blueAccent
  ];
  // final colors = Colors.accents.sublist(0, 5);
  List<Widget> getCards() {
    final list = <Widget>[];
    // final list = <String?>[];
    for (final cat in controller.data!.categories) {
      for (var x = 0; x < cat.subCats!.length; ++x) {
        final color = x < colors.length
            ? colors[x]
            : colors[x - (x ~/ colors.length) * colors.length];
        final item = controller.subCats[x];
        final card = _CategoryCard(
          text: item!,
          color: color,
          onTap: () {
            controller.onSubCategoryTap(subCategory: item, category: cat.name);
          },
        );
        list.add(card);
      }
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return _CatList(
      children: getCards(),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  final Color? color;
  final VoidCallback? onTap;
  final String text;
  const _CategoryCard({Key? key, this.color, this.onTap, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _color = color ?? primaryColor(context);
    return text.text.capitalize
        .size(16)
        .semiBold
        .color(_color)
        .textStyle(GoogleFonts.nunitoSans())
        .makeCentered()
        .box
        .px24
        .color(_color.withOpacity(0.07))
        .withRounded(value: radius)
        .make()
        .pOnly(right: 8)
        .onTap(() => onTap?.call());
  }
}

class _CatList extends StatelessWidget {
  const _CatList({
    Key? key,
    required this.children,
  }) : super(key: key);
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 50,
        child: ListView.builder(
          itemCount: children.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, i) {
            return children[i];
          },
        ),
      ),
    );
  }
}

class _Banners extends GetView<HomeController> {
  const _Banners({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: VxSwiper.builder(
        autoPlay: true,
        itemCount: 10,
        viewportFraction: 0.9,
        height: 180,
        enableInfiniteScroll: false,
        enlargeCenterPage: true,
        itemBuilder: (context, index) {
          return _Banner(banner: controller.data!.banners[index]).px(2);
        },
      ),
    );
  }
}

class _Banner extends GetView<HomeController> {
  final AppBanner banner;

  const _Banner({Key? key, required this.banner}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CachedImage(url: banner.img!).onTap(
      () => controller.handleLink(banner.toDynamicLink()),
    );
  }
}

class _Heading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          "Fashion 24x7 "
              .text
              .bold
              .size(30)
              .color(const Color(0xff14284a))
              .textStyle(GoogleFonts.varelaRound())
              .make(),
          verSpacing10,
          "Where Fashion Meets Your Soul"
              .text
              .size(17)
              .color(const Color(0xff14284a))
              .make(),
        ],
      ),
    );
  }
}

class _AppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            color: Vx.gray700,
            onPressed: () {},
            icon: const Icon(Icons.menu),
          ).box.roundedFull.color(Vx.gray500.withOpacity(0.1)).make(),
          const _CartIcon(),
        ],
      ).py16(),
    );
  }
}

class _CartIcon extends GetView<HomeController> {
  const _CartIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      splashRadius: 28,
      onPressed: controller.onCartTap,
      icon: const Icon(Icons.shopping_bag_outlined),
      color: Vx.gray700,
    ).box.roundedFull.color(Vx.gray500.withOpacity(0.1)).make();
  }
}
