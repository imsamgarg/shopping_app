import 'package:custom_utils/spacing_utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopping_app/app/core/global_widgets/widgets.dart';
import 'package:shopping_app/app/core/theme/color_theme.dart';
import 'package:shopping_app/app/core/theme/sizing_theme.dart';
import 'package:shopping_app/app/core/values/values.dart';
import 'package:velocity_x/velocity_x.dart';

class ShimmerProduct extends StatelessWidget {
  final Axis direction;

  const ShimmerProduct({Key? key, this.direction = Axis.vertical})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (direction == Axis.vertical) {
      return Container(
        child: Column(
          children: [
            const SizedBox(
              height: 5,
            ),
            Expanded(
                flex: 7,
                child: const ShimmerContainer().box.roundedFull.make()),
            const SizedBox(
              height: 10,
            ),
            Flexible(
              child: Row(
                children: [
                  const Expanded(flex: 8, child: ShimmerContainer()),
                  Expanded(flex: 2, child: Container()),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Flexible(
              child: Row(
                children: [
                  const Expanded(child: ShimmerContainer()),
                  Expanded(child: Container()),
                ],
              ),
            ),
          ],
        ),
      );
    }
    return CardSkeleton(
      child: Row(
        children: <Widget>[
          const Expanded(flex: 4, child: const ShimmerContainer()),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            flex: 6,
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 30,
                    child: ShimmerContainer(),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const SizedBox(
                    height: 20,
                    width: 80,
                    child: const ShimmerContainer(),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const SizedBox(
                    height: 20,
                    width: 40,
                    child: const ShimmerContainer(),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }
}

class ShimmerAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SafeArea(
        child: Container(
          height: 70,
          padding: Sizing.sidePadding,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                ShimmerContainer(
                  height: 50,
                  width: 60,
                ),
                ShimmerContainer(
                  height: 50,
                  width: 60,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Heading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: "Fashion 24x7 "
          .text
          .bold
          .size(26)
          .color(ColorTheme.headerColor)
          .textStyle(GoogleFonts.varelaRound())
          .make(),
    );
  }
}

class HomeShimmer extends StatelessWidget {
  const HomeShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            verSliverSpacing16,
            _Heading(),
            verSliverSpacing16,
            const ShimmerSliverProductGrid(
              itemCount: 10,
            ),
          ],
        ).px16(),
      ),
    );
  }
}

// class HomeShimmer extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return ColoredBox(
//       color: Vx.white,
//       child: CustomScrollView(
//         key: const ValueKey("loading"),
//         slivers: [
//           ShimmerAppBar(),
//           _Heading(),
//           const SliverToBoxAdapter(
//             child: SizedBox(
//               height: 20,
//             ),
//           ),
//           SliverToBoxAdapter(
//             child: Padding(
//               padding: Sizing.sidePadding,
//               child: Container(
//                 height: 30,
//                 padding: const EdgeInsets.only(left: 8),
//                 child: Row(
//                   mainAxisSize: MainAxisSize.max,
//                   children: [
//                     const Expanded(child: ShimmerContainer()),
//                     Expanded(child: Container()),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           const SliverToBoxAdapter(
//             child: const SizedBox(
//               height: 5,
//             ),
//           ),
//           const ShimmerSliverProductGrid(),
//           const SliverToBoxAdapter(
//             child: const SizedBox(
//               height: 20,
//             ),
//           ),
//           SliverToBoxAdapter(
//             child: Padding(
//               padding: Sizing.sidePadding,
//               child: Container(
//                 height: 30,
//                 padding: const EdgeInsets.only(left: 8),
//                 child: Row(
//                   mainAxisSize: MainAxisSize.max,
//                   children: [
//                     const Expanded(child: const ShimmerContainer()),
//                     Expanded(child: Container()),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           const SliverToBoxAdapter(
//             child: const SizedBox(
//               height: 5,
//             ),
//           ),
//           const ShimmerSliverProductGrid(),
//         ],
//       ),
//     );
//   }
// }

// class ShimmerBottomBar extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BottomAppBar(
//       child: Material(
//         child: Container(
//           height: 60,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             // mainAxisSize: MainAxisSize.max,
//             children: [
//               ShimmerContainer(
//                 width: 50,
//                 height: 50,
//               ),
//               ShimmerContainer(
//                 width: 50,
//                 height: 50,
//               ),
//               ShimmerContainer(
//                 width: 50,
//                 height: 50,
//               ),
//               ShimmerContainer(
//                 width: 50,
//                 height: 50,
//               ),
//               ShimmerContainer(
//                 width: 50,
//                 height: 50,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

class ShimmerProductGrid extends StatelessWidget {
  final int itemCount;
  final bool isList;

  const ShimmerProductGrid({Key? key, this.itemCount = 10, this.isList = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      child: GridView(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: kProductWidth,
          mainAxisSpacing: 10,
          mainAxisExtent: kProductHeight,
          crossAxisSpacing: 10,
        ),
        children: List.generate(itemCount, (index) {
          return const ShimmerProduct(
            direction: Axis.vertical,
          );
        }),
      ),
      padding: Sizing.sidePadding,
    );
  }
}

class ShimmerSliverProductGrid extends StatelessWidget {
  final int itemCount;
  final bool isList;

  const ShimmerSliverProductGrid({
    Key? key,
    this.itemCount = 10,
    this.isList = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final children = List.generate(itemCount, (index) {
      return const ShimmerProduct(
        direction: Axis.vertical,
      );
    });
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: kProductWidth,
        mainAxisSpacing: 10,
        mainAxisExtent: kProductHeight,
        crossAxisSpacing: 10,
      ),
      delegate: SliverChildListDelegate.fixed(children),
      // children: List.generate(itemCount, (index) {
      //   return const ShimmerProduct(
      //     direction: Axis.vertical,
      //   );
      // }),
    );
  }
}

class ShimmerCartGrid extends StatelessWidget {
  final int itemCount;
  final bool isList;

  const ShimmerCartGrid({Key? key, this.itemCount = 10, this.isList = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const ValueKey("loading"),
      appBar: AppBar(
        title: const Text("Loading"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            // maxCrossAxisExtent: kProductWidth,
            mainAxisSpacing: 10,
            mainAxisExtent: kHorProductHeight,
            crossAxisSpacing: 10, crossAxisCount: 1,
          ),
          children: List.generate(itemCount, (index) {
            return const ShimmerProduct(
              direction: Axis.horizontal,
            );
          }),
        ),
      ),
    );
  }
}
// ShimmerProduct(
// direction: isList ? Axis.horizontal : Axis.vertical,
// )

class ShimmerContainer extends StatelessWidget {
  final double? height;
  final double? width;

  const ShimmerContainer({Key? key, this.height, this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: Sizing.borderRadiusL,
        color: Colors.grey,
      ),
      height: height,
      width: width ?? double.infinity,
    ).shimmer(
      primaryColor: Colors.grey[300]!,
      secondaryColor: Colors.grey[100],
    );
  }
}
