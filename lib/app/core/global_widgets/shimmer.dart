// import 'package:flutter/material.dart';

// import 'package:velocity_x/velocity_x.dart';

// import 'package:shopping_app/app/core/theme/sizing_theme.dart';

// class ShimmerContainer extends StatelessWidget {
//   const ShimmerContainer({
//     Key? key,
//     this.color,
//     this.borderRadius,
//   }) : super(key: key);

//   final Color? color;
//   final double? borderRadius;

//   @override
//   Widget build(BuildContext context) {
//     return VxShimmer(
//       child: const SizedBox.expand(),
//       primaryColor: color ?? Colors.grey,
//     ).box.withRounded(value: borderRadius ?? Sizing.radiusL).make();
//   }
// }

// class ShimmerCard extends StatelessWidget {
//   const ShimmerCard({Key? key, this.axis = Axis.vertical}) : super(key: key);
//   final Axis axis;
//   @override
//   Widget build(BuildContext context) {
//     if (axis == Axis.horizontal) {
//       return const _HorShimmerCard();
//     } else {
//       return const _VerShimmerCard();
//     }
//   }
// }

// class _VerShimmerCard extends StatelessWidget {
//   const _VerShimmerCard({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }

// class _HorShimmerCard extends StatelessWidget {
//   const _HorShimmerCard({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }
