import 'package:flutter/material.dart';
import 'package:shopping_app/app/core/values/values.dart';

class Sizing {
  static const borderRadius = BorderRadius.all(Radius.circular(5));
  static const borderRadiusXl = BorderRadius.all(Radius.circular(25));

  ///Ver:-8 Hor:-20
  static const sidePadding = EdgeInsets.symmetric(vertical: 8, horizontal: 20);

  ///left:20
  static const leftPadding = EdgeInsets.only(left: 20);

  static final cardShape =
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius));
  static final roundShape =
      RoundedRectangleBorder(borderRadius: borderRadiusXl);

  static const radiusS = 8.0;
}
