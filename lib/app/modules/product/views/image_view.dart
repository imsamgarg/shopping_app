import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';

class ImageView extends StatelessWidget {
  final String image;

  const ImageView({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InteractiveViewer(
          child: CachedNetworkImage(imageUrl: image),
        ),
      ),
    );
  }
}
