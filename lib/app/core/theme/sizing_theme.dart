import 'package:flutter/material.dart';

import 'package:shopping_app/app/core/values/values.dart';

class Sizing {
  static const borderRadiusS = BorderRadius.all(Radius.circular(radiusS));
  static const borderRadiusM = BorderRadius.all(Radius.circular(radiusM));
  static const borderRadiusL = BorderRadius.all(Radius.circular(radiusL));
  static const borderRadiusXL = BorderRadius.all(Radius.circular(radiusXL));
  static const borderRadiusXLL = BorderRadius.all(Radius.circular(25));

  ///Ver:-8 Hor:-20
  static const sidePadding = EdgeInsets.symmetric(vertical: 8, horizontal: 20);

  ///left:20
  static const leftPadding = EdgeInsets.only(left: 20);

  static final cardShape =
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(kRadius));
  static const roundShape =
      RoundedRectangleBorder(borderRadius: borderRadiusXLL);

  static const radiusS = 8.0;
  static const radiusM = 12.0;
  static const radiusL = 15.0;
  static const radiusXL = 20.0;
}
