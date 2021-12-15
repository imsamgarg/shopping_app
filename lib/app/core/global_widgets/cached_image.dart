import 'package:firebase_image/firebase_image.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/app/core/theme/sizing_theme.dart';

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
    return ClipRRect(
      borderRadius: borderRadius ?? Sizing.borderRadiusL,
      child: Image(
        fit: boxFit ?? BoxFit.cover,
        image: FirebaseImage(
          url,
        ),
      ),
    );
  }
}
