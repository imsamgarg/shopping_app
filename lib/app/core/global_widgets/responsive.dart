import 'package:flutter/material.dart';
import 'package:shopping_app/app/core/values/assets.dart';
import 'package:shopping_app/app/core/values/values.dart';
import 'package:velocity_x/velocity_x.dart';

class AdaptiveHide extends StatelessWidget {
  final Widget child;
  final ScreenSize hideOn;

  const AdaptiveHide({Key? key, required this.hideOn, required this.child})
      : super(key: key);

  Widget calculateSizeAndBuild(BuildContext c) {
    final _screenSize = c.mq.size.height - c.mq.viewInsets.bottom;
    if (hideOn == ScreenSize.sm && _screenSize >= sm) return child;
    if (hideOn == ScreenSize.md && _screenSize >= md) return child;
    if (hideOn == ScreenSize.lg && _screenSize >= lg) return child;
    if (hideOn == ScreenSize.xl && _screenSize >= xl) return child;
    return SizedBox();
  }

  @override
  Widget build(BuildContext context) {
    return calculateSizeAndBuild(context);
  }
}

class HeaderImage extends StatelessWidget {
  const HeaderImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdaptiveHide(
      hideOn: ScreenSize.lg,
      child: Hero(
        tag: "image",
        child: Container(
          child: Image.asset(
            Assets.assetsImagesWelcome,
          ),
        ),
      ),
    );
  }
}
