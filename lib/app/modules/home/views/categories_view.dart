import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:shopping_app/app/modules/home/controllers/tap_controller.dart';

class CategoriesView extends GetView<TapController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CategoriesView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'CategoriesView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
