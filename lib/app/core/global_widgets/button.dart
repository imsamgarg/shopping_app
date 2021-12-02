// import 'package:flutter/material.dart';

// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:velocity_x/velocity_x.dart';

// class CustomButton extends StatelessWidget {
//   final Widget child;
//   final bool isLoading;
//   final VoidCallback onPressed;
//   final EdgeInsets? padding;
//   final double? elevation;
//   final Color? bgColor;
//   final Color? fgColor;
//   final bW;
//   final bStyle;
//   final bColor;
//   final overlayColor;

//   CustomButton(
//       {Key? key,
//       required this.child,
//       this.isLoading = false,
//       required this.onPressed,
//       this.padding,
//       this.elevation = 0.0,
//       this.bgColor,
//       this.fgColor = ColorTheme.whiteColor,
//       this.bW = 0.0,
//       this.bStyle = BorderStyle.none,
//       this.bColor = ColorTheme.accentColor,
//       this.overlayColor})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return TextButton(
//       style: ButtonStyle(
//         elevation: MaterialStateProperty.resolveWith((_) => elevation),
//         overlayColor: MaterialStateColor.resolveWith(
//             (states) => overlayColor ?? Color(0xff208b5d)),
//         foregroundColor: MaterialStateColor.resolveWith((states) => fgColor!),
//         shape: MaterialStateProperty.resolveWith((states) => Sizing.cardShape),
//         backgroundColor: MaterialStateColor.resolveWith(
//             (states) => bgColor ?? ColorTheme.accentColor),
//         padding: MaterialStateProperty.resolveWith(
//           (states) =>
//               padding ??
//               const EdgeInsets.symmetric(
//                 vertical: 18,
//                 horizontal: 10,
//               ),
//         ),
//         side: MaterialStateProperty.resolveWith(
//             (states) => BorderSide(color: bColor, style: bStyle, width: bW)),
//       ),
//       onPressed: isLoading ? () {} : onPressed,
//       child: isLoading
//           ? SpinKitThreeBounce(
//               color: fgColor,
//               size: 20,
//             )
//           : child,
//     );
//   }
// }

// class NextButton extends CustomButton {
//   NextButton(onPressed, {isLoading = false})
//       : super(
//             child: "Next".text.size(16).make(),
//             onPressed: onPressed,
//             isLoading: isLoading);
// }

// class DoneButton extends CustomButton {
//   DoneButton(onPressed, {isLoading = false})
//       : super(
//             child: "Done".text.size(16).make(),
//             onPressed: onPressed,
//             isLoading: isLoading);
// }

// // class SocialButton extends CustomOutlinedButton {
// //   SocialButton(
// //     logo,
// //     String text,
// //     onPressed,
// //   ) : super(
// //             onPressed: onPressed,
// //             child: Row(
// //               mainAxisAlignment: MainAxisAlignment.center,
// //               children: [
// //                 Image.asset(
// //                   logo,
// //                   height: 22,
// //                 ),
// //                 const SizedBox(
// //                   width: 10,
// //                 ),
// //                 text.text.size(16).capitalize.make(),
// //               ],
// //             ),
// //             padding: const EdgeInsets.all(15));
// // }
// //
// // class GoogleButton extends SocialButton {
// //   GoogleButton(onPressed) : super(gLogo, "login with google", onPressed);
// // }
// //
// // class FacebookButton extends SocialButton {
// //   FacebookButton(onPressed) : super(fbLogo, "login with facebook", onPressed);
// // }

// class CustomOutlinedButton extends CustomButton {
//   CustomOutlinedButton(
//       {Key? key,
//       required Widget child,
//       bool isLoading = false,
//       required VoidCallback onPressed,
//       double? elevation,
//       EdgeInsets? padding,
//       double? bW,
//       Color? overlayColor,
//       Color? bC})
//       : super(
//             key: key,
//             fgColor: ColorTheme.accentColor,
//             overlayColor:
//                 overlayColor ?? ColorTheme.accentColor.withOpacity(0.2),
//             bgColor: ColorTheme.primaryColors[4],
//             child: child,
//             isLoading: isLoading,
//             elevation: elevation,
//             onPressed: onPressed,
//             padding: padding,
//             bStyle: BorderStyle.none,
//             // bColor: bC ?? accentColor,
//             bW: bW ?? 1.0);
// }

// class DialogButton extends StatelessWidget {
//   final VoidCallback onTap;
//   final Color color;
//   final Color textColor;
//   final String heading;
//   final bool isLoading;

//   const DialogButton({
//     Key? key,
//     required this.onTap,
//     required this.color,
//     required this.heading,
//     this.isLoading = false,
//     this.textColor = Vx.white,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: 80,
//       height: 40,
//       child: CustomButton(
//         child: heading.text.color(textColor).make(),
//         padding: const EdgeInsets.all(0),
//         bgColor: color,
//         isLoading: isLoading,
//         onPressed: onTap,
//       ),
//     );
//   }
// }
