import 'package:flutter/material.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:shopping_app/app/modules/home/controllers/home_controller.dart';

class CenterLoading extends StatelessWidget {
  const CenterLoading({
    Key? key,
    this.size = 50.0,
    this.color,
  }) : super(key: key);

  final double size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitThreeBounce(
        color: color ?? Theme.of(context).colorScheme.primary,
        size: size,
      ),
    );
  }
}

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}

const kEmptyWidget = EmptyWidget();

class CartIcon extends GetView<HomeController> {
  final Color? color;
  final Color? backgroundColor;
  const CartIcon({this.color, this.backgroundColor, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 50,
      child: MaterialButton(
        elevation: 0,
        hoverElevation: 0,
        focusElevation: 0,
        highlightElevation: 0,
        padding: EdgeInsets.zero,
        color: backgroundColor,
        shape: const CircleBorder(),
        onPressed: controller.onCartTap,
        child: Icon(
          Icons.shopping_bag_outlined,
          color: color,
        ),
      ),
    );
  }
}

// class RoundedDp extends StatelessWidget {
//   const RoundedDp({
//     Key? key,
//     this.url,
//     this.name,
//   }) : super(key: key);

//   final String? url;
//   final String? name;
//   @override
//   Widget build(BuildContext context) {
//     return ClipOval(child: ProfilePicture());
//   }
// }

// class ProfilePicture extends GetView<UserController> {
//   ProfilePicture({
//     Key? key,
//     this.url,
//     this.name,
//   }) : super(key: key);

//   final String? url;
//   final String? name;

//   @override
//   Widget build(BuildContext context) {
//     return Obx(
//       () {
//         String url = controller.profilePicture ?? "";
//         String name = controller.userName;
//         return CachedNetworkImage(
//           imageUrl: url,
//           fit: BoxFit.cover,
//           placeholder: (context, url) {
//             // if (loadingProgress == null) return child;
//             return CenterLoading(size: 25);
//           },
//           errorWidget: (context, error, stackTrace) {
//             return Container(
//               color: Theme.of(context).primaryColor,
//               child: Center(
//                 child: "${name[0]}".text.white.size(48).make(),
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
// }

// class CustomChip extends StatelessWidget {
//   const CustomChip(this.text, {this.isActive = false, this.onTap});
//   final bool isActive;
//   final String text;
//   final VoidCallback? onTap;

//   @override
//   Widget build(BuildContext context) {
//     final boxColor = isActive ? primaryColor(context) : Vx.white;
//     final textColor = isActive ? Vx.white : ColorTheme.primaryColors[2];
//     final borderColor =
//         isActive ? primaryColor(context) : ColorTheme.primaryColors[3];

//     return text.text
//         .color(textColor)
//         .size(15)
//         .make()
//         .box
//         .p8
//         .color(boxColor)
//         .border(color: borderColor)
//         .make()
//         .onTap(onTap ?? () {});
//   }
// }

// class DisplayName extends GetView<UserController> {
//   const DisplayName({Key? key, this.size = 18}) : super(key: key);

//   final double? size;
//   @override
//   Widget build(BuildContext context) {
//     return Obx(
//       () => controller.userName.text
//           .size(size)
//           .semiBold
//           .color(ColorTheme.primaryColors[1])
//           .make(),
//     );
//   }
// }
