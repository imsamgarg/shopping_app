import 'package:flutter/material.dart';

import 'package:shopping_app/app/core/global_widgets/cached_image.dart';

class ImageView extends StatelessWidget {
  final String image;

  const ImageView({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Image"),
        elevation: 1,
      ),
      body: InteractiveViewer(
        child: Center(
          child: Hero(
            tag: image,
            child: CachedImage(
              url: image,
              borderRadius: BorderRadius.zero,
            ),
          ),
        ),
      ),
    );
  }
}
