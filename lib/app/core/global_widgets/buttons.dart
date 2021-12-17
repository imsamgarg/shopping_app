import 'package:flutter/material.dart';
import 'package:shopping_app/app/core/global_widgets/widgets.dart';
import 'package:shopping_app/app/core/theme/sizing_theme.dart';
import 'package:shopping_app/app/core/utils/helper.dart';
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
  final double loadingSize;
  final VoidCallback onTap;
  final BorderRadius? borderRadius;
  final EdgeInsets? padding;

  const AppTextButton({
    Key? key,
    this.isLoading = false,
    required this.onTap,
    this.color,
    required this.child,
    this.foregroundColor,
    this.padding,
    this.borderRadius,
    this.loadingSize = 18,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateColor.resolveWith(
          (states) {
            if (states.contains(MaterialState.pressed)) {
              if (foregroundColor != null) {
                return foregroundColor!.withOpacity(0.5);
              }
              return primaryColor(context).withOpacity(0.5);
            }
            return color ?? primaryColor(context);
          },
        ),
        overlayColor: MaterialStateColor.resolveWith(
          (states) {
            if (foregroundColor != null) {
              return foregroundColor!.withOpacity(0.2);
            }
            return primaryColor(context).withOpacity(0.7);
          },
        ),
        foregroundColor: MaterialStateColor.resolveWith(
          (states) => foregroundColor ?? Vx.white,
        ),
        padding: MaterialStateProperty.resolveWith(
          (states) {
            return padding ?? const EdgeInsets.all(18);
          },
        ),
        shape: MaterialStateProperty.resolveWith((states) {
          return RoundedRectangleBorder(
            borderRadius: borderRadius ?? Sizing.borderRadiusXL,
          );
        }),
      ),
      onPressed: isLoading ? () {} : onTap,
      child: isLoading
          ? CenterLoading(
              size: loadingSize,
              color: foregroundColor ?? Vx.white,
            )
          : child,
    );
  }
}

class AppOutlinedButton extends StatelessWidget {
  final bool isLoading;
  final Color? color;
  final Color? foregroundColor;
  final Widget child;
  final double loadingSize;
  final VoidCallback onTap;
  final BorderRadius? borderRadius;
  final EdgeInsets? padding;

  const AppOutlinedButton({
    Key? key,
    this.isLoading = false,
    required this.onTap,
    this.color,
    required this.child,
    this.foregroundColor,
    this.padding,
    this.borderRadius,
    this.loadingSize = 18,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: ButtonStyle(
          backgroundColor: MaterialStateColor.resolveWith(
            (states) {
              if (states.contains(MaterialState.pressed)) {
                if (foregroundColor != null) {
                  return foregroundColor!.withOpacity(0.2);
                }
                return primaryColor(context).withOpacity(0.2);
              }
              return color ?? Vx.white;
            },
          ),
          overlayColor: MaterialStateColor.resolveWith(
            (states) {
              if (foregroundColor != null) {
                return foregroundColor!.withOpacity(0.05);
              }
              return primaryColor(context).withOpacity(0.05);
            },
          ),
          foregroundColor: MaterialStateColor.resolveWith(
            (states) => foregroundColor ?? primaryColor(context),
          ),
          padding: MaterialStateProperty.resolveWith(
            (states) {
              return padding ?? const EdgeInsets.all(18);
            },
          ),
          shape: MaterialStateProperty.resolveWith((states) {
            return RoundedRectangleBorder(
              borderRadius: borderRadius ?? Sizing.borderRadiusXL,
            );
          }),
          side: MaterialStateProperty.resolveWith((states) {
            return BorderSide(color: foregroundColor ?? primaryColor(context));
          })),
      onPressed: isLoading ? () {} : onTap,
      child: isLoading
          ? CenterLoading(
              size: 18,
              color: foregroundColor ?? primaryColor(context),
            )
          : child,
    );
  }
}

class DialogButton extends StatelessWidget {
  final VoidCallback onTap;
  final Color? color;
  final Color textColor;
  final String heading;
  final bool isLoading;

  const DialogButton({
    Key? key,
    required this.onTap,
    this.color,
    required this.heading,
    this.isLoading = false,
    this.textColor = Vx.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80,
      height: 40,
      child: AppTextButton(
        child: heading.text.make(),
        padding: const EdgeInsets.all(0),
        color: color ?? Vx.white,
        isLoading: isLoading,
        loadingSize: 14,
        foregroundColor: textColor,
        onTap: onTap,
      ),
    );
  }
}
