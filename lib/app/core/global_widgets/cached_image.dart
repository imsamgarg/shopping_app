import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_image/firebase_image.dart';
import 'package:shopping_app/app/core/global_widgets/shimmers.dart';

import 'package:shopping_app/app/core/theme/sizing_theme.dart';
import 'package:shopping_app/app/core/values/assets.dart';

Widget _errorBuilder(c, e, s) {
  return Image.asset(
    Assets.assetsImagesErrorNotFound,
  );
}

class CachedFirebaseImage extends StatelessWidget {
  const CachedFirebaseImage({
    Key? key,
    required this.url,
    this.borderRadius,
    this.boxFit,
  }) : super(key: key);
  final String url;
  final BorderRadius? borderRadius;
  final BoxFit? boxFit;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? Sizing.borderRadiusL,
      child: Image(
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return const ShimmerContainer();
        },
        errorBuilder: _errorBuilder,
        fit: boxFit ?? BoxFit.cover,
        image: FirebaseImage(url),
      ),
    );
  }
}

class CachedHTTPImage extends StatelessWidget {
  const CachedHTTPImage({
    Key? key,
    required this.url,
    this.borderRadius,
    this.boxFit,
  }) : super(key: key);
  final String url;
  final BorderRadius? borderRadius;
  final BoxFit? boxFit;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? Sizing.borderRadiusL,
      child: CachedNetworkImage(
        imageUrl: url,
        errorWidget: _errorBuilder,
        placeholder: (context, url) {
          return const ShimmerContainer();
        },
        fit: boxFit ?? BoxFit.cover,
      ),
    );
  }
}

class CachedImage extends StatelessWidget {
  const CachedImage({
    Key? key,
    required this.url,
    this.borderRadius,
    this.boxFit,
  }) : super(key: key);
  final String url;
  final BorderRadius? borderRadius;
  final BoxFit? boxFit;
  @override
  Widget build(BuildContext context) {
    //if it starts with gs then it will use firebase image
    if (url.startsWith(RegExp("gs", caseSensitive: false))) {
      return CachedFirebaseImage(
        url: url,
        borderRadius: borderRadius,
        boxFit: boxFit,
      );
    }
    // else use cachednetwork image
    return CachedHTTPImage(
      url: url,
      borderRadius: borderRadius,
      boxFit: boxFit,
    );
  }
}
