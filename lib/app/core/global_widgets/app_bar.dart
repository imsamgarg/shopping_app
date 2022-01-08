import 'package:flutter/material.dart';
import 'package:shopping_app/app/core/global_widgets/widgets.dart';

class AppBarWithCartIcon extends AppBar {
  AppBarWithCartIcon(String title)
      : super(actions: const [CartIcon()], title: Text(title));
}

class SliverAppBarWithCartIcon extends SliverAppBar {
  SliverAppBarWithCartIcon(String title)
      : super(actions: const [CartIcon()], title: Text(title));
}
