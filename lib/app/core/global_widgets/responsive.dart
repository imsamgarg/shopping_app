import 'package:flutter/material.dart';
import 'package:shopping_app/app/core/values/assets.dart';
import 'package:velocity_x/velocity_x.dart';

// class AdaptiveHide extends StatelessWidget {
//   final Widget child;
//   final ScreenSize hideOn;
//   final double viewInsets;

//   const AdaptiveHide(
//       {Key? key,
//       required this.hideOn,
//       required this.child,
//       this.viewInsets = 0})
//       : super(key: key);

//   Widget calculateSizeAndBuild(BuildContext c) {
//     final height = c.mq.size.height;
//     final insets = c.mq.viewInsets.bottom;
//     final _screenSize = height - viewInsets;
//     if (hideOn == ScreenSize.sm && _screenSize >= sm) return child;
//     if (hideOn == ScreenSize.md && _screenSize >= md) return child;
//     if (hideOn == ScreenSize.lg && _screenSize >= lg) return child;
//     if (hideOn == ScreenSize.xl && _screenSize >= xl) return child;
//     return SizedBox();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return calculateSizeAndBuild(context);
//   }
// }

class HeaderImage extends StatelessWidget {
  final double viewInsets;
  final String? image;
  const HeaderImage({
    Key? key,
    required this.viewInsets,
    this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "image",
      child: SizedBox(
        height: (context.screenHeight - viewInsets) * 0.35,
        child: Image.asset(
          image ?? Assets.assetsImagesWelcome,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
