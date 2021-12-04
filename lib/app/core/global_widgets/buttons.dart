import 'package:flutter/material.dart';
import 'package:shopping_app/app/core/values/assets.dart';
import 'package:shopping_app/app/core/values/values.dart';

class GoogleButton extends StatelessWidget {
  final VoidCallback? onTap;

  const GoogleButton({
    Key? key,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "google",
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
        ),
        onPressed: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 13.0),
          child: Image.asset(
            Assets.assetsImagesGLogo,
            height: 30,
            width: 30,
          ),
        ),
        // child: Icon(Icons.)
      ),
    );
  }
}

class CallButton extends StatelessWidget {
  final VoidCallback? onTap;

  const CallButton({
    Key? key,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "call",
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
        ),
        onPressed: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Icon(
            Icons.call,
          ),
        ),
      ),
    );
  }
}
