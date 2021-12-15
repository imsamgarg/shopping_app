import 'package:flutter/material.dart';
import 'package:shopping_app/app/core/global_widgets/widgets.dart';
import 'package:shopping_app/app/core/theme/sizing_theme.dart';
import 'package:shopping_app/app/core/values/assets.dart';
import 'package:velocity_x/velocity_x.dart';

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
            borderRadius: Sizing.borderRadiusXLL,
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
            borderRadius: Sizing.borderRadiusXLL,
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

class AppTextButton extends StatelessWidget {
  final bool isLoading;
  final Color? color;
  final Color? foregroundColor;
  final Widget child;
  final VoidCallback onTap;

  const AppTextButton({
    Key? key,
    this.isLoading = false,
    required this.onTap,
    this.color,
    required this.child,
    this.foregroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: color != null
          ? ButtonStyle(
              backgroundColor: MaterialStateColor.resolveWith(
                (states) {
                  if (states.contains(MaterialState.pressed)) {
                    return color!.withOpacity(0.7);
                  }
                  return color!;
                },
              ),
              foregroundColor: MaterialStateColor.resolveWith(
                (states) => foregroundColor ?? Vx.white,
              ),
            )
          : TextButton.styleFrom(
              // primary: Vx.white,
              padding: const EdgeInsets.all(18),
              shape: Sizing.roundShape,
            ),
      onPressed: isLoading ? () {} : onTap,
      child: isLoading
          ? CenterLoading(
              size: 18,
              color: foregroundColor,
            )
          : child,
    );
  }
}
